 //
 //  HomeService.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 16.04.2022.
 //

import Foundation
import Firebase
import FirebaseDatabase
import CoreLocation
import GeoFire

struct HomeService : HomeProtocol {
 
 
 var geofire: GeoFire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
 
 var locationManager: LocationManager = LocationManager.shared
 
 
 var auth: Auth = Firebase.Auth.auth()
 
 var database: Database = FirebaseDatabase.Database.database()
 
 func getUserCredentials( completionHandler :@escaping  (String)-> Void) {
  guard let uid = auth.currentUser?.uid else { return }
  database.reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
   guard let dictionary = snapshot.value as? [String: Any] else {return}
   guard let email = dictionary["email"] as? String else { return }
   completionHandler(email)
  }
 }
 
 func fetchDrivers(location: CLLocation, completion: @escaping (User) -> Void ) {
  REF_DRIVER_LOCATIONS.observe(.value, with: { snapshot in
   geofire.query(at: location, withRadius: 50).observe(.keyEntered, with: { uid, location in
    fetchUserByUid(uid: uid) { user in
     var driver = user
     driver.location = location
     completion(driver)
    }
   })
  }
  )
 }



 
 func fetchUserByUid(uid: String,completion : @escaping (User) -> Void) {
  REF_USERS.child(uid).observe(.value) { snapshot in
   guard let data = snapshot.value as? [String: String] else { return }
   let driver = User.init(dictionary: data)
   completion(driver)
  }
 }
 

}
