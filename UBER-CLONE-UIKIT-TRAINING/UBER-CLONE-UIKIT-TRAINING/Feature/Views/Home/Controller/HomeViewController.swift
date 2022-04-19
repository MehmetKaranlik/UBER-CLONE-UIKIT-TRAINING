import Foundation
import UIKit
import Firebase
import MapKit


class HomeViewController : UIViewController, LocationActivationViewDelegate, LocationInputViewDelegate {
 
 
 
 
  // MARK:  properties
 
 
 let locationManager : LocationManager = LocationManager.shared

 let service : HomeService = HomeService()
 
 let mapView : MKMapView = MKMapView()

 var headerText : String? {
  didSet {locationInputView.titleLabel.text = headerText ?? ""}
 }

 var headerSectionHeight : CGFloat = 200
 
 private let locationActivasionView : LocationActivationView =  LocationActivationView()
 
 private let locationInputView : InputView = InputView()

 private let tableView = UITableView()
 
 
  // MARK: Lifecyle
 
  // MARK: Selectors
 




 override func viewDidLoad() {
  super.viewDidLoad()

  checkUserStatus()
  locationManager.enableLocationServices()
  awakeView()
 }
 
 
 
  // MARK:  Makers

 fileprivate func configureUI() {
  view.backgroundColor = .red
  navigationController?.navigationBar.isHidden = true
  makeMapView()
  makeInputView()
  configureTableView()
 }


 fileprivate func fetchDrivers() {
  var authStatus = locationManager.locationManager.authorizationStatus

  if authStatus == .denied && authStatus == .notDetermined && authStatus == .restricted {

   print("calisti")

   locationManager.locationManager.requestAlwaysAuthorization()

   fetchDrivers()
  }else {

   guard let location = locationManager.locationManager.location else {return}

   print(location)

   service.fetchDrivers(location: location) { user in

    guard let coordinate = user.location?.coordinate else { return }
     // to check is that anno is already visible on map
    var driverIsVisible : Bool {

     return self.mapView.annotations.contains { annotations in

      guard let driverAnno = annotations as? DriverAnnotation else { return false}

      if driverAnno.uid == user.email {
        // update position custom func #note : to make this work coordinate property needed to be declared as dynamic var
       driverAnno.updateAnnotationPosition(withCoordinate: coordinate)

       return true
      }
      return false
     }
    }
    if !driverIsVisible {
     self.mapView.addAnnotation(DriverAnnotation(uid: user.email, coordinate: coordinate))
    }
   }
  }
 }

 

 func getUserCredentials() {
  service.getUserCredentials { email in
   self.headerText = email
  }
 }
 
 fileprivate func makeMapView() {
  view.addSubview(mapView)
  configureMapView()
 }
 
 fileprivate func configureMapView() {
  mapView.frame = view.frame
  mapView.showsUserLocation = true
  mapView.userTrackingMode = .follow
  mapView.delegate = self

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

 fileprivate func configureTableView() {
  tableView.delegate = self
  tableView.dataSource = self
  tableView.register(CellWithSubtitleTableViewCell.self, forCellReuseIdentifier: locationReuseIdentifier)
  tableView.allowsSelection = false
  tableView.rowHeight = 60
  tableView.backgroundColor = .groupTableViewBackground
  tableView.sectionIndexBackgroundColor = .red
  tableView.sectionHeaderHeight = 5
  let height = view.frame.height - headerSectionHeight
  tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height)

  view.addSubview(tableView)
 }


 
 
 
  // MARK: Functions

 func awakeView() {
  configureUI()
  getUserCredentials()
  fetchDrivers()
 }
 
 func checkUserStatus() {
  if (Firebase.Auth.auth().currentUser?.uid) != nil  {
   print("user was already logged in")
   awakeView()
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
    self.tableView.frame.origin.y = self.view.frame.height
    self.locationActivasionView.alpha = 1
    self.tableView.alpha = 0
    self.locationInputView.removeFromSuperview()
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
  UIView.animate(withDuration: 0.8) {
   self.tableView.frame.origin.y = 200
   self.tableView.alpha = 1
  }
  configureLocationInputView()
 }
 
 
}


// MARK:  TableView Options
extension HomeViewController :UITableViewDataSource, UITableViewDelegate {
 func numberOfSections(in tableView: UITableView) -> Int {
  return 2
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: locationReuseIdentifier, for: indexPath) as! CellWithSubtitleTableViewCell
  return cell
 }

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return section == 0 ? 2 : 5
 }

 func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
  return "  "
 }





}



// to set Custom Annotation View
extension HomeViewController : MKMapViewDelegate {
 func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
  if let annotation = annotation as? DriverAnnotation {
   let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "DriverAnno")
   view.image = UIImage(named: "chevron-sign-to-right")
   return view
  }
  return nil
 }
}





