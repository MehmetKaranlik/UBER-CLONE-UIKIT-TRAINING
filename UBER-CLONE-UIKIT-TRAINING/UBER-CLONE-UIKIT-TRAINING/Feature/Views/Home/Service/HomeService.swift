//
//  HomeService.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 16.04.2022.
//

import Foundation
import Firebase
import FirebaseDatabase

struct HomeService : HomeProtocol {
 var auth: Auth = Firebase.Auth.auth()

 var database: Database = FirebaseDatabase.Database.database()

 func getUserCredentials( completionHandler :@escaping  (String)-> Void) {
  print("getUserCredentials calisti")
  guard let uid = auth.currentUser?.uid else { return }
  database.reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
   print("Debug: \(snapshot.value)")
   guard let dictionary = snapshot.value as? [String: Any] else {return}
   guard let email = dictionary["email"] as? String else { return }
   print("burasi calisti")
   print(email)
   completionHandler(email)
  }
 }


}
