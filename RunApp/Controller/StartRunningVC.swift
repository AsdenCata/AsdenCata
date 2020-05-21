//
//  StartRunningVC.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 20/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import UIKit
import MapKit

class StartRunningVC: LocationVC { //inherit everithing from LocationVC
    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        manager?.stopUpdatingLocation()
    }
    
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }
    
    @IBAction func startRunningBtnPressed(_ sender: Any) {
        guard let onRun = storyboard?.instantiateViewController(identifier: "OnRunVC") as? OnRunVC else { return }
        present(onRun, animated: true, completion: nil)

    }
    
}

extension StartRunningVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways { //it is mandatory to check if user has approved to share location
            mapView.showsUserLocation = true // to show the user location
            mapView.userTrackingMode = .follow
        }
    }
    
}
