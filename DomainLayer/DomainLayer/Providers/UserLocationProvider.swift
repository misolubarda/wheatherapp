//
//  UserLocationProvider.swift
//  DomainLayer
//
//  Created by Nikola Matijevic on 10/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation


public protocol UserLocationProvider {
    func fetchLocation(completion: @escaping(Response<UserLocation>) -> Void)
}
