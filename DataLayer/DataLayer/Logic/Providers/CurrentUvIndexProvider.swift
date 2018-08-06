//
//  CurrentUvIndexProvider.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/29/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

public class CurrentUvIndexProvider: UvIndexProvider {
    public init() {}

    public func fetch(for coordinate: Coordinate, completion: @escaping (Response<CurrentUvIndex>) -> Void) {
        guard let request = Request(endpoint: .currentUvIndex(coordinate: coordinate)).urlRequest else { return }
        WebService(session: DataNetworkSession()).execute(request, callback: completion)
    }
}
