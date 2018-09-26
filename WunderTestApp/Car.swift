//
//  Car.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 24.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation

public enum CarCondition: String {
    case good             = "okIcon.png"
    case unacceptable     = "badIcon.png"
}



struct Car {
    let address: String
    let coordinates: [Float]
    let engineType: String
    let exterior: CarCondition
    let fuel: Int
    let interior: CarCondition
    let name: String
    let vin: String


}


struct Locations {
    let placemarks: [Car]
}

extension Locations: Decodable {
    
    private enum LocationStructKeys: String, CodingKey {
        case placemarks = "placemarks"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationStructKeys.self)
        let placemarks = try container.decode([Car].self, forKey: .placemarks)
    
        self.init(placemarks: placemarks)
        
    }
    
    
}



extension Car: Decodable {
    
   public enum CarStructKeys: String, CodingKey {
        case address = "address"
        case coordinates = "coordinates"
        case engineType = "engineType"
        case exterior = "exterior"
        case fuel = "fuel"
        case interior = "interior"
        case name = "name"
        case vin = "vin"
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CarStructKeys.self)
        
        let address = try container.decode(String.self, forKey: .address)
        let coordinates = try container.decode([Float].self, forKey: .coordinates)
        let engineType = try container.decode(String.self, forKey: .engineType)
        
        let tempStringExterior = try container.decode(String.self, forKey: .exterior)
        let exterior = (tempStringExterior == "GOOD" ? CarCondition.good : CarCondition.unacceptable)
        
        let tempStringInterior = try container.decode(String.self, forKey: .interior)
        let interior = (tempStringInterior == "GOOD" ? CarCondition.good : CarCondition.unacceptable)

        let fuel = try container.decode(Int.self, forKey: .fuel)
        let name = try container.decode(String.self, forKey: .name)
        let vin = try container.decode(String.self, forKey: .vin)

        self.init(address: address, coordinates: coordinates, engineType: engineType, exterior: exterior, fuel: fuel, interior: interior, name: name, vin: vin)
        
    }
    
}


