//
//  Route.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 26.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation

struct Route {
    
    let distance: String
    let time: String
    let polylinePath: String
    
    //MARK: - failable init
    init?(data: JSON) {
        guard let routesArray = data["routes"] as? NSArray else { return nil }
        guard let routes = routesArray[0] as? JSON else { return nil }
        
        if let polylineData = routes["overview_polyline"] as? JSON {
            guard let polyline = polylineData["points"] as? String else { return nil }
            self.polylinePath = polyline
        } else { return nil }
        
        guard let routeData = routes["legs"] as? [JSON] else { return nil }
        if let distance = routeData[0]["distance"] as? JSON {
            guard let value = distance["text"] as? String else { return nil }
            self.distance = value
        } else { return nil }
        
        if let time = routeData[0]["duration"] as? JSON {
            guard let value = time["text"] as? String else { return nil }
            self.time = value
        } else { return nil }
    }

}

