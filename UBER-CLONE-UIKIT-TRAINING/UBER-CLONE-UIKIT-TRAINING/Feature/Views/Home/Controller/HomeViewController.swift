import Foundation
import UIKit
import Firebase
import MapKit
class HomeViewController : UIViewController, LocationActivationViewDelegate, LocationInputViewDelegate {
 
 
 
 
  // MARK:  properties
 
 
 let locationManager : LocationManager = LocationManager.shared
 
 let mapView : MKMapView = MKMapView()
 
 private let locationActivasionView : LocationActivationView =  LocationActivationView()
 
 private let locationInputView : LocationInputView = LocationInputView()
 
 
  // MARK: Lifecyle
 
  // MARK: Selectors
 
 override func viewDidLoad() {
  
  super.viewDidLoad()
  view.backgroundColor = .red
  navigationController?.navigationBar.isHidden = true
  makeMapView()
  checkUserStatus()
  locationManager.enableLocationServices()
  makeInputView()
 }
 
 
 
  // MARK:  Makers
 
 fileprivate func makeMapView() {
  view.addSubview(mapView)
  configureMapView()
 }
 
 fileprivate func configureMapView() {
  mapView.frame = view.frame
  mapView.showsUserLocation = true
  mapView.userTrackingMode = .follow
 }
 
 fileprivate func makeInputView() {
  view.addSubview(locationActivasionView)
  
  locationActivasionView.centerX(inView: view)
  locationActivasionView.delegate = self
  locationActivasionView.anchor(top:view.safeAreaLayoutGuide.topAnchor,
                                paddingTop: 40,
                                paddingBottom: 0,
                                width : view.frame.width - 64,
                                height: 50)
  
 }
 
 
 
 
  // MARK: Functions
 
 func checkUserStatus() {
  if (Firebase.Auth.auth().currentUser?.uid) != nil  {
   print("user was already logged in")
  }else {
   let vc = UINavigationController(rootViewController: LoginController())
   vc.modalPresentationStyle = .fullScreen
   present(vc, animated: false)
  }
 }
 
 func logout() {
  do {
   try  Firebase.Auth.auth().signOut()
  }catch {
   print("error while loggin out")
  }
  
 }
 
 
 
 
 
 func dismissLocationInputView() {
  UIView.animate(withDuration: 0.3) {
   self.locationInputView.alpha = 0
  } completion: { _ in
   UIView.animate(withDuration: 0.3) {
    self.locationActivasionView.alpha = 1
   }
  }
 }
 
 
 func configureLocationInputView() {
  view?.addSubview(locationInputView)
  locationInputView.delegate = self
  locationInputView.anchor(top: view.topAnchor,  right: view.rightAnchor, left: view.leftAnchor, height: 200)
  locationInputView.alpha = 0
  UIView.animate(withDuration: 0.5) {
   self.locationInputView.alpha = 1
  }
 }
 
 func presentLocationInputView() {
  locationActivasionView.alpha = 0
  configureLocationInputView()
 }
 
 
}





