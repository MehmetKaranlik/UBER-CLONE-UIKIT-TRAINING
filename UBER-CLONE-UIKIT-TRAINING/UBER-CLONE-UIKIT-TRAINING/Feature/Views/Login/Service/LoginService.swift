 //
 //  LoginService.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 15.04.2022.
 //

import Foundation
import Firebase

struct LoginService : LoginProtocol {
 
 var auth: Auth = Auth.auth()


 func loginUser(email: String, password: String, completionHandler: @escaping () -> Void) {
  Auth.auth().signIn(withEmail: email, password: password) { result, error in
   if let err = error {
    print("DEBUG: \(err.localizedDescription)")
    return
   }
   print("DEBUG: Successfully logged in")
   completionHandler()
  }
 }


}
