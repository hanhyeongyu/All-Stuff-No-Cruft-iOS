//
//  Address.swift
//
//
//  Created by 한현규 on 8/28/24.
//

import Foundation
import CoreLocation


struct Address: Decodable{
    let city: String
    let street: String
    let zipCode: String
    let coordinate: Coordinate
    
    func fullAddress() -> String{
        "\(city) \(street)"
    }
}


struct Coordinate: Decodable{
    let latitude: Double
    let longitude: Double
    
    func clLocationCoordinate() -> CLLocationCoordinate2D{
        return CLLocationCoordinate2D(
            latitude: self.latitude,
            longitude: self.longitude
        )
    }
}
