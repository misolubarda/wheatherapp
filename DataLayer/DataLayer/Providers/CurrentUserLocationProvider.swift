//
//  UserLocationProvider.swift
//  DataLayer
//
//  Created by Nikola Matijevic on 10/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer
import CoreLocation

public class CurrentUserLocationProvider:  NSObject, UserLocationProvider, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    func userAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    public func fetchLocation(completion: @escaping (Response<UserLocation>) -> Void) {
        guard let location = locationManager.userLocation else {
            completion(.error(LocationError.locationUnavailable))
            return
        }
        completion(.success(location))
    }
}

private extension CLLocationManager {
    var userLocation: UserLocation? {
        guard let location = location else { return nil }
        return UserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}

public enum LocationError: Error {
    case locationUnavailable
}
