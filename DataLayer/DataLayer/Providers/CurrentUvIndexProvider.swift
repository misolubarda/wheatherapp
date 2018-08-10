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
    private let webService: WebService

    public init() {
        self.webService = WebService(session: DataNetworkSession())
    }

    public func fetch(for coordinate: Coordinate, completion: @escaping (Response<CurrentUvIndex>) -> Void) {
        guard let request = Request(endpoint: .currentUvIndex(coordinate: coordinate)).urlRequest else { return }
        webService.execute(request, callback: completion)
    }
}
