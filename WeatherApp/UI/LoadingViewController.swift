//
//  LoadingViewController.swift
//  WeatherApp
//
//  Created by Nikola Matijevic on 11/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol LoadingViewControllerDependencies {
    var locationProvider : UserLocationProvider { get }
}

class LoadingViewController:  UIViewController {
    private let dependencies: LoadingViewControllerDependencies
    
    init(dependencies: LoadingViewControllerDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    func fetchLocation(completion: @escaping (Response<UserLocation>) -> Void) {
        dependencies.locationProvider.fetchLocation(completion: completion)
    }
}
