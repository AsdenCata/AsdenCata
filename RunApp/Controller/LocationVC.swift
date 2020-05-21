//
//  LocationVC.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 20/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import UIKit
import MapKit

//we crete this VC to avoid writing same code twice (for StartRunning and OnRUNVC)
class LocationVC: UIViewController, MKMapViewDelegate {
    
    var manager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest //setting best accuracy as we are walking, not driving
        manager?.activityType = .fitness

    }
    
    func checkLocationAuthStatus() { //cheking if user has accepted to share location
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse || CLLocationManager.authorizationStatus() != .authorizedAlways {
            manager?.requestWhenInUseAuthorization()
        }
        
    }

}
