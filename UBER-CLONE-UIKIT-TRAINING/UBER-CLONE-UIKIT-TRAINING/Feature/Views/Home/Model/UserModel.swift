//
//  UserModel.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 16.04.2022.
//

import Foundation
import CoreLocation


struct User {
 let email: String
 let userType: UserType.RawValue
 var location : CLLocation?

 init(dictionary : [String: Any]) {
  self.email = dictionary["email"] as! String
  self.userType = dictionary["userType"] as! UserType.RawValue
 }
}
