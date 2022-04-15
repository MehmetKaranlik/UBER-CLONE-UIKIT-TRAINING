//
//  RegisterProtocol.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 15.04.2022.
//

import Foundation
import Firebase
import FirebaseDatabase

protocol RegisterProtocol {

 func registerUser(email: String, password: String, userType: String) -> Void

 var auth : Auth { get }
 var database : Database { get }



}
