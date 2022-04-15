 //
 //  LocationManager.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 15.04.2022.
 //

import Foundation
import MapKit


class LocationManager : NSObject, CLLocationManagerDelegate {
 
 static let shared : LocationManager = LocationManager()
 let locationManager = CLLocationManager()
 
 
 
 func enableLocationServices() {
  locationManager.delegate = self
  switch locationManager.authorizationStatus {
   case .notDetermined:
    locationManager.requestAlwaysAuthorization()
   case .restricted:
    locationManager.requestAlwaysAuthorization()
   case .denied:
    locationManager.requestAlwaysAuthorization()
   case .authorizedAlways,.authorizedWhenInUse,.authorized:
    locationManager.startUpdatingLocation()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    break
   @unknown default:
    break
  }
 }
 
 func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
  if status == .authorizedWhenInUse {
   locationManager.requestAlwaysAuthorization()
  }
 }
}
