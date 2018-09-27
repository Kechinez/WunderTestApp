//
//  NetworkManager.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 24.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import CoreLocation
public typealias JSON = [String: Any]


public enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

extension CLLocationCoordinate2D {
    func coordinatesToString() -> String {
        print(String(self.latitude) + "," + String(self.longitude))
        return String(self.latitude) + "," + String(self.longitude)
    }
}



class NetworkManager {
    static let shared = NetworkManager()
    
    init() {}
    
    private let session = URLSession(configuration: .default)
    private let urlString = String("https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json")
    private var getRouteTask: URLSessionTask?
    
   
    func getRouteRequest(with startCoordinate: CLLocationCoordinate2D, and finishCoordinate: CLLocationCoordinate2D, completionHandler: @escaping (APIResult<Route>) -> ()) {
        
        getRouteTask?.cancel()
        //let session = URLSession.shared
        let startStringCoordinate = startCoordinate.coordinatesToString()//self.coordinatesToString(with: startCoordinate)
        let finishStringCoordinate = finishCoordinate.coordinatesToString()//self.coordinatesToString(with: finishCoordinate)
        let stringURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(startStringCoordinate)&destination=\(finishStringCoordinate)&mode=driving&language=en&key=AIzaSyAmV1T_J6_noWuMYBJukYv3-eDBvhr3zmY"
        let url = URL(string: stringURL)!
        let request = URLRequest(url: url)
        //let request = GoogleAPIRequests.DirectionAPI(sourceCoordinate: startStringCoordinate, destCoordinate: finishStringCoordinate).request
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.Failure(error))
                }
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! JSON
                guard let routeInfo = Route(data: json)  else { return }
                DispatchQueue.main.async {
                    completionHandler(.Success(routeInfo))
                }
            } catch {
                print("can't convert to JSON object!")
            }
        }.resume()
        
    }
    
    
    
    func getCars(completionHandler: @escaping ((APIResult<[Car]>) -> ())) {
        
        let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: encodedURL!) else { return }
        
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                
                DispatchQueue.main.async {
                    completionHandler(APIResult.Failure(error!))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(APIResult.Failure(error!))
                }
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let carsData = try JSONDecoder().decode(Locations.self, from: data!)
                    DispatchQueue.main.async {
                        completionHandler(APIResult.Success(carsData.placemarks))
                    }
                    return
                    
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(APIResult.Failure(error))
                    }
                    return
                }
                
            default:
                print(httpResponse.statusCode)
                let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Requested resource could not be found!", comment: "")]
                let error = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                DispatchQueue.main.async {
                    completionHandler(APIResult.Failure(error))
                }
                return
            }
            }.resume()
        
        
        
    }
    
    
    
    
}
    

    
    
    


    








