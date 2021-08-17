//
//  ViewController.swift
//  NaverMap_Practice
//
//  Created by 다훈김 on 2021/08/16.
//

import UIKit
import CoreLocation
import NMapsMap

class ViewController: UIViewController  {
    
    var locationManager:CLLocationManager!
    
    let marker = NMFMarker()
    
    var lat: Double?
    var lng: Double?
    
    @IBOutlet weak var mapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        moveCamera()
        currentLoactionOverray()
 
        
    }
    
    @IBAction func myLoactionButtonTapped(_ sender: UIButton) {
        moveCamera()
    }
    
    func currentLocation() {
        let coor = locationManager.location?.coordinate
        lat = coor?.latitude
        lng = coor?.longitude
    }
    
    func moveCamera() {
        currentLocation()
        let cameraUpdate = NMFCameraUpdate(scrollTo:  NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0), zoomTo: 17)
        mapView.moveCamera(cameraUpdate)
    }
    
    func currentLoactionOverray() {
        mapView.positionMode = .direction
    }
}

extension ViewController: CLLocationManagerDelegate {
//    pod 'Moya/RxSwift', '~> 14.0'
}
