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
    private let locationManager = CLLocationManager()
    private var completion: ((Response<UserLocation>) -> Void)?
    

    private var isLocationServiceEnabled: Bool  {
        return CLLocationManager.locationServicesEnabled()
    }
    
    private func requestAuthorizationIfNeeded() -> Bool {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            self.locationManager.requestWhenInUseAuthorization()
            return true
        }
        return false
    }
    
    private func requestLocation() {
        locationManager.startUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            requestLocation()
        } else if status == .denied || status == .restricted {
            completion?(.error(LocationError.locationServiceDisabled))
            completion = nil
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latitude = locations.first?.coordinate.latitude else { return }
        guard let longitude = locations.first?.coordinate.longitude else { return }
        let finalLocation = UserLocation(latitude: latitude, longitude: longitude)
        completion?(Response.success(finalLocation))
        completion = nil
        return
    }
    
    public func fetchLocation(completion: @escaping (Response<UserLocation>) -> Void) {
        guard isLocationServiceEnabled else {
            completion(.error(LocationError.locationServiceDisabled))
            return
        }
        if !requestAuthorizationIfNeeded()  {
            requestLocation()
        }
        self.completion = completion
    }
}

private extension CLLocationManager {
    var userLocation: UserLocation? {
        guard let location = location else { return nil }
        return UserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}

public enum LocationError: Error {
    case locationServiceDisabled, locationUnavailable
}
