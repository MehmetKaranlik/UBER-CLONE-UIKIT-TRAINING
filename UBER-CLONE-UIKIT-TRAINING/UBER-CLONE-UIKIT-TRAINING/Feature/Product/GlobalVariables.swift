//
//  GlobalVariables.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 16.04.2022.
//

import Foundation
import Firebase

//  db reference
let DB_REF = Database.database().reference()


// user db reference
let REF_USERS = DB_REF.child("users")




// driver locations db reference

let REF_DRIVER_LOCATIONS = DB_REF.child("driver-locations")
