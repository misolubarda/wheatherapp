//
//  UserLocation.swift
//  DomainLayer
//
//  Created by Nikola Matijevic on 10/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public struct UserLocation {
    let latitude: Double
    let longitude: Double
    
    public init(latitude:Double ,longitude:Double){
        self.latitude = latitude
        self.longitude = longitude
    }
}
