//
//  UserType.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 15.04.2022.
//

import Foundation

enum UserType : String {
 case rider,driver
}





extension UserType {

}

public func getUserType(index : Int) -> String {
 switch index {
  case 0:
   return UserType.driver.rawValue
  case 1:
   return UserType.rider.rawValue
  default:
   return UserType.rider.rawValue
 }
 }
