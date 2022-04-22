//
//  PlacemarkExtensions.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 21.04.2022.
//

import Foundation
import MapKit


extension MKPlacemark {

 func returnAddress() -> String {
  var address = String()
  if let street = self.thoroughfare {
   address.append(street + ", ")
  }
  if let city = self.locality {
   address.append(city + ", ")
  }
  if let countryCode = self.countryCode {
   address.append(countryCode)
  }
  return address
 }
}
