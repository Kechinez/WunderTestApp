//
//  NetworkManager.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 24.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation



public enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}



class NetworkManager {
    static let shared = NetworkManager()
    
    init() {}
    
    private let session = URLSession(configuration: .default)
    private let urlString = String("https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json")
    
    
    
    
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
    

    
    
    


    








