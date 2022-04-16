//
//  CustomDriverAnotation.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 16.04.2022.
//

import MapKit

class DriverAnnotation : NSObject, MKAnnotation {
 
 dynamic var coordinate: CLLocationCoordinate2D
 var uid : String

  init(uid: String, coordinate :CLLocationCoordinate2D) {
  self.uid = uid
  self.coordinate = coordinate
 }


 func updateAnnotationPosition(withCoordinate coordinate: CLLocationCoordinate2D) {
  UIView.animate(withDuration: 0.2) {
   self.coordinate = coordinate
  }
 }
}
