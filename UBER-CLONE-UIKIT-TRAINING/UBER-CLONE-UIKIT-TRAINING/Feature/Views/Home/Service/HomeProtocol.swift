//
//  HomeProtocol.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 16.04.2022.
//

import Foundation
import Firebase
import FirebaseDatabase

protocol HomeProtocol {

 var auth : Auth { get }
 var database: Database { get }

 func getUserCredentials( completionHandler : @escaping (String)-> Void)

}
