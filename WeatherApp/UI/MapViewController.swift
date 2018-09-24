//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Nikola Matijevic on 24/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//
import UIKit
import MapKit
import DomainLayer

 protocol MapViewControllerDependencies {
    var locationProvider: UserLocationProvider{ get }
}

class MapViewController: UIViewController {
    private let dependencies: MapViewControllerDependencies
    @IBOutlet var mapView: MKMapView!
    
    
    init(dependencies: MapViewControllerDependencies){
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    
    func fetchLocation(completion: @escaping (Response<UserLocation>) -> Void) {
        dependencies.locationProvider.fetchLocation { response in
            switch response {
                case .success(let location):
                    break
                case .error(let error):
                    break
            }
        }
    }
    
    }



