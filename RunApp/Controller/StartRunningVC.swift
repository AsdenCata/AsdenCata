//
//  StartRunningVC.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 20/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

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
        locationCenterBtnPressed(self)
    }
    
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegion.init(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func startRunningBtnPressed(_ sender: Any) {
        guard let onRun = storyboard?.instantiateViewController(withIdentifier: "OnRunVC") as? OnRunVC else { return }
        present(onRun, animated: true, completion: nil)
    }
    
    func centerMapOnPreviousRoute(locations: List<Location>) -> MKCoordinateRegion {
        guard let initialLoc = locations.first else { return MKCoordinateRegion() }
        var minLat = initialLoc.latitude
        var minLong = initialLoc.longitude
        var maxLat = minLat      //just setting an initial value
        var maxLong = minLong
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLong = min(minLong, location.longitude)
            maxLat = max(maxLat, location.longitude)
            maxLong = max(maxLong, location.longitude)
        }
        
        
        
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLong + maxLong) / 2), span: MKCoordinateSpan(latitudeDelta: (maxLat-minLat)*3, longitudeDelta: (maxLong-minLong)*3)) //center: minLat+MaxLat/2 shows middle of Lat; span: set the zoom level to the map
    }
    
    func setupMapView() {
        if let overlay = addLastRunToMap() { //check if we have a last run
            if mapView.overlays.count > 0 { //check if our map already has a overlay, as we wish to show only the last one
                mapView.removeOverlays(mapView.overlays)
                mapView.userTrackingMode = .follow
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
        
        mapView.userTrackingMode = .none //turning off traking user when center map to route
        mapView.setRegion(centerMapOnPreviousRoute(locations:  lastRun.locations), animated: true)
         
        return MKPolyline(coordinates: coordinate, count: lastRun.locations.count)
    }
}

extension StartRunningVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways { //it is mandatory to check if user has approved to share location
            mapView.showsUserLocation = true // to show the user location
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
