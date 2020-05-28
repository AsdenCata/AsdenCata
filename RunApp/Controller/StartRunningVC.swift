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
    
    @IBOutlet weak var lastRunCLoseBtn: UIButton!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunView: UIView!
    @IBOutlet weak var lastRunStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager?.delegate = self
        manager?.startUpdatingLocation()
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        manager?.stopUpdatingLocation()
    }
    
    @IBAction func lastRunCloseBtnPressed(_ sender: Any) {
        lastRunView.isHidden = true
        lastRunStackView.isHidden = true
        lastRunCLoseBtn.isHidden = true
    }
    
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }
    
    @IBAction func startRunningBtnPressed(_ sender: Any) {
        guard let onRun = storyboard?.instantiateViewController(withIdentifier: "OnRunVC") as? OnRunVC else { return }
        present(onRun, animated: true, completion: nil)
    }
    
    func getLastRun() {
        if let lastRun = Run.getAllRuns()?.first {
            lastRunView.isHidden = false
            lastRunStackView.isHidden = false
            lastRunCLoseBtn.isHidden = false
            paceLbl.text = lastRun.pace.formatTimeDurationToString()
            distanceLbl.text = "\(lastRun.distance.metersToKm(decimals: 2)) km"
            durationLbl.text = lastRun.duration.formatTimeDurationToString()
            
        } else {
            lastRunCloseBtnPressed(self)
        }
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
