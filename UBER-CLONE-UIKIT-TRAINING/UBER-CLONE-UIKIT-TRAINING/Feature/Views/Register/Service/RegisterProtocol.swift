//
//  RegisterProtocol.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 15.04.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import GeoFire

protocol RegisterProtocol {

 func registerUser(email: String, password: String, userType: String,completionHandler: @escaping (String) -> Void) -> Void

 var auth : Auth  { get }
 var database : Database { get }

}
