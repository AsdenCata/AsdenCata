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
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager?.delegate = self
        mapView.delegate = self
        manager?.startUpdatingLocation()
//        setupMapView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMapView()
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
    
    func setupMapView() {
        if let overlay = addLastRunToMap() { //check if we have a last run
            if mapView.overlays.count > 0 { //check if our map already has a overlay, as we wish to show only the last one
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overlay)  //adding last run on the map
            lastRunView.isHidden = false
            lastRunStackView.isHidden = false
            lastRunCLoseBtn.isHidden = false
            
        } else {
            lastRunCloseBtnPressed(self)
        }
    }
    
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Run.getAllRuns()?.first  else { return nil }
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToKm(decimals: 2)) km"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
        var coordinate = [CLLocationCoordinate2D]()
        for loc in lastRun.locations {
            print("Location lat:\(loc.latitude), long: \(loc.longitude)")
            coordinate.append(CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude))
            print("Coordinates: \(coordinate)")
        }
        return MKPolyline(coordinates: coordinate, count: lastRun.locations.count)
    }
}

extension StartRunningVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways { //it is mandatory to check if user has approved to share location
            mapView.showsUserLocation = true // to show the user location
            mapView.userTrackingMode = .follow
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        renderer.lineWidth = 4
        return renderer
        
    }
    
}
