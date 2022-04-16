//
//  HomeProtocol.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 16.04.2022.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreLocation
import GeoFire

protocol HomeProtocol {

 var auth : Auth { get }
 var database: Database { get }
 var locationManager : LocationManager { get }
 var geofire : GeoFire { get }

 func getUserCredentials( completionHandler : @escaping (String)-> Void)
 func fetchDrivers(location : CLLocation,completion: @escaping (User) -> Void)
 func fetchUserByUid(uid: String, completion : @escaping (User) -> Void)

}
