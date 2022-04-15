//
//  LoginProtocol.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 15.04.2022.
//

import Foundation
import Firebase

protocol LoginProtocol {

 var auth:Auth { get }

 func loginUser(email:String, password: String, completionHandler : @escaping () -> Void) -> Void
}
