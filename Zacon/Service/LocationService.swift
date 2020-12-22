//
//  LocationService.swift
//  Zacon
//
//  Created by Mikhail Danilov on 06.12.2020.
//

import CoreLocation
import RxRelay
import RxCocoa

class LocationService : NSObject , CLLocationManagerDelegate {
    
    var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let rxlocation = BehaviorRelay(value: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()
    
    
    func start() {
        print("LocationService>start")
        locationManager.startUpdatingLocation()
        //locationManager.startUpdatingHeading()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue = manager.location {
            if locValue.coordinate.latitude != 0 {
                location = locValue.coordinate
                rxlocation.accept(CLLocationCoordinate2D(latitude: locValue.coordinate.latitude, longitude: locValue.coordinate.longitude))
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted:
            print("GPS Restricted Access to location")
        case CLAuthorizationStatus.denied:
            print("GPS User denied access to location")
        case CLAuthorizationStatus.notDetermined:
            print("GPS Status not determined")
        default:
            print("GPS Allowed to location Access")
        }
    }
    
}
