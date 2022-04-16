 //
 //  RegisterService.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 15.04.2022.
 //

import Foundation
import Firebase
import FirebaseDatabase
import GeoFire


struct RegisterService : RegisterProtocol {

 var auth: Auth = Auth.auth()

 var database: Database = Database.database()

 func registerUser(email: String, password: String, userType: String,completionHandler: @escaping (String) -> Void) {

  auth.createUser(withEmail: email, password: password) { result, error in

   if let err = error {

    print("DEBUG: Something went wrong with register : \(err)")

    return
   }

   guard let uid = result?.user.uid else {return}
   print(uid)
   let values : [String: Any] = ["email" : email, "password" : password, "userType": userType ]
   REF_USERS
    .child(uid)
    .updateChildValues(values) { error, ref in

     print("DEBUG : burasi calisti")

     if let err = error {

      print("DEBUG:\(err.localizedDescription)")

      return
     }

     print("DEBUG: Successfully created user.")
     completionHandler(uid)

    }

  }

 }

}
