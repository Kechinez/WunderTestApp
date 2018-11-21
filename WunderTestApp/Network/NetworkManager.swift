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
    case success(T)
    case failure(Error)
}

//MARK: - Building API request
private enum ApiRequests {
    case getCars
    case getRoute(sourceCoordinate: String, destCoordinate: String)
    
    private var baseURL: URL? {
        switch self {
        case .getCars:
            let urlString = String("https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json")
            let cleanedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "unvalidURL"
            return URL(string: cleanedUrlString)
        case .getRoute:
            let urlString = String("https://maps.googleapis.com/maps/api/")
            return URL(string: urlString)
        }
    }
    
    private var apiKey: String {
        return "AIzaSyAmV1T_J6_noWuMYBJukYv3-eDBvhr3zmY"
    }
    
    private var path: String {
        switch self {
        case .getRoute(let sourceCoordinate, let destCoordinate):
            return String("directions/json?origin=\(sourceCoordinate)&destination=\(destCoordinate)&mode=driving&language=en&key=\(apiKey)")
        default: return ""
        }
    }
    var request: URLRequest? {
        switch self {
        case .getCars:
            guard let url = baseURL else { return nil }
            return URLRequest(url: url)
        case .getRoute:
            guard let url = URL(string: path, relativeTo: baseURL) else { return nil }
            return URLRequest(url: url)
        }
        
    }
}


//MARK: Network manager 
final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let session = URLSession(configuration: .default)
    private var getRouteTask: URLSessionTask?
    
    
    private func returnHandlerOnMainQueue<T>(with result: APIResult<T>, handler: @escaping ((APIResult<T>) -> ())) {
        DispatchQueue.main.async {
            handler(result)
        }
    }
   
    func getRoute(with startCoordinate: CLLocationCoordinate2D, and finishCoordinate: CLLocationCoordinate2D, completionHandler: @escaping (APIResult<Route>) -> ()) {
        
        getRouteTask?.cancel()
        let startStringCoordinate = startCoordinate.coordinatesToString()
        let finishStringCoordinate = finishCoordinate.coordinatesToString()
        guard let request = ApiRequests.getRoute(sourceCoordinate: startStringCoordinate, destCoordinate: finishStringCoordinate).request else { return }
        
        let dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
            
            if let error = error {
                self?.returnHandlerOnMainQueue(with: .failure(error), handler: completionHandler)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! JSON
                guard let routeInfo = Route(data: json)  else { return }
                self?.returnHandlerOnMainQueue(with: .success(routeInfo), handler: completionHandler)

            } catch {
                print("can't convert to JSON object!")
            }
        }
        getRouteTask = dataTask
        dataTask.resume()
        
    }
    
    
    func getCars(completionHandler: @escaping ((APIResult<[Car]>) -> ())) {
        
        guard let request = ApiRequests.getCars.request else { return }
        
        session.dataTask(with: request) {  [weak self] (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Server replied with invalid protocol!", comment: "")]
                let httpError = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                self?.returnHandlerOnMainQueue(with: .failure(httpError), handler: completionHandler)
                return
            }
            guard error == nil && data != nil else {
                self?.returnHandlerOnMainQueue(with: .failure(error!), handler: completionHandler)
                return
            }
            switch httpResponse.statusCode {
            case 200:
                do {
                    let carsData = try JSONDecoder().decode(Locations.self, from: data!)
                    self?.returnHandlerOnMainQueue(with: .success(carsData.placemarks), handler: completionHandler)
                    return
                } catch let error {
                    self?.returnHandlerOnMainQueue(with: .failure(error), handler: completionHandler)
                    return
                }
                
            default:
                let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Requested resource could not be found!", comment: "")]
                let error = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                self?.returnHandlerOnMainQueue(with: .failure(error), handler: completionHandler)
                return
            }
            }.resume()
    }
    
    
}
    

