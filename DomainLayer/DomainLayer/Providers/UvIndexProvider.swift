//
//  UvIndexProvider.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 8/6/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol UvIndexProvider {
    func fetch(for coordinate: Coordinate, completion: @escaping (Response<CurrentUvIndex>) -> Void)
}
