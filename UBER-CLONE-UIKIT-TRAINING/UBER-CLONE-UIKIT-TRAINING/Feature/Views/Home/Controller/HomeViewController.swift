import Foundation
import UIKit
import Firebase
import MapKit


class HomeViewController : UIViewController, LocationActivationViewDelegate, LocationInputViewDelegate {





 var searchResutls : [MKPlacemark] = [MKPlacemark]()

  // MARK:  properties

 private let locationManager : LocationManager = LocationManager.shared

 private let service : HomeService = HomeService()
 
 private let mapView : MKMapView = MKMapView()

 private var isDestinationSelected : Bool = false {
  didSet {
   if isDestinationSelected {
    self.actionButton
     .setImage(UIImage(named: "baseline_arrow_back_black_36dp-1")?
      .withRenderingMode(.alwaysOriginal), for:  .normal)
   }else{
    self.actionButton
     .setImage(UIImage(named: "baseline_menu_black_36dp")?
      .withRenderingMode(.alwaysOriginal), for:  .normal)
   }
  }
 }

 private var route : MKRoute?



 var headerText : String? {
  didSet {locationInputView.titleLabel.text = headerText ?? ""}
 }

 var headerSectionHeight : CGFloat = 200

 private let locationActivasionView : LocationActivationView =  LocationActivationView()
 
 private let locationInputView : InputView =  InputView()

 private let tableView = UITableView()

 private let actionButton : UIButton = {
  let button = UIButton(type: .system)
  button.setImage(UIImage(named: "baseline_menu_black_36dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
  button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
  return button
 }()
 
 
  // MARK: Lifecyle


  // MARK: Selectors

 @objc func actionButtonPressed() {
  if isDestinationSelected == true {
   isDestinationSelected = false
  removeAnnotationsAndOverlays()
  }else {
   print("Hok")
  }
 }

 override func viewDidLoad() {
  super.viewDidLoad()
  checkUserStatus()
  locationManager.enableLocationServices()
  awakeView()
 }
 
 
 
  // MARK:  Makers

 fileprivate func makeSideMenuButton() {
  view.addSubview(actionButton)
  actionButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 50, paddingBottom: 0, paddingRight: 0, paddingLeft: 20,width: 30 , height: 30)
 }

 fileprivate func configureUI() {
  view.backgroundColor = .red
  navigationController?.navigationBar.isHidden = true
  makeMapView()
  makeInputView()
  configureTableView()
  makeSideMenuButton()

 }


 public func fetchDrivers()  {

  var authStatus  = locationManager.locationManager.authorizationStatus
  if authStatus == .denied && authStatus == .notDetermined && authStatus == .restricted {
   locationManager.locationManager.requestAlwaysAuthorization()
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
  tableView.allowsMultipleSelection = false
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

 func executeSearch(query: String) {
  searchBy(naturalLanguageQuery: query) { results in
   self.searchResutls = results
   self.tableView.reloadData()
  }
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
 
 
 
 



 func dismissLocationInputView(completion: ((Bool)-> Void)?) {
  UIView.animate(withDuration: 0.3, animations: {
   self.locationInputView.alpha = 0
   self.tableView.frame.origin.y = self.view.frame.height
   self.tableView.alpha = 0
   self.locationInputView.removeFromSuperview()
   UIView.animate(withDuration: 10) {
    self.locationActivasionView.alpha = 1

   }

  }, completion: completion)
 }



 
 func configureLocationInputView() {
  view?.addSubview(locationInputView)
  locationInputView.inputViewDelegate = self
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

 func removeAnnotationsAndOverlays() {
  self.mapView.annotations.forEach { annotation in
   if let anno = annotation as? MKPointAnnotation {
    self.mapView.removeAnnotation(anno)
   }
   self.mapView.removeOverlays(self.mapView.overlays)
  }
  mapView.setCamera(
   .init(
    lookingAtCenter: mapView.userLocation.coordinate,
    fromDistance: 3500, pitch: 0,
    heading: CLLocationDirection(2)), animated: true)
 }
 
 
}


 // MARK:  TableView Options
extension HomeViewController :UITableViewDataSource, UITableViewDelegate {
 func numberOfSections(in tableView: UITableView) -> Int {
  return 2
 }


 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return section == 0 ? 2 : searchResutls.count
 }

 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView
   .dequeueReusableCell(withIdentifier: locationReuseIdentifier, for: indexPath) as! CellWithSubtitleTableViewCell

  if indexPath.section == 1 {
   cell.placemark = searchResutls[indexPath.row]
  }

  return cell
 }

 func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {return "  "}

 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  let selectedPlaceMark = self.searchResutls[indexPath.row]
  print("DEBUG: Selected placemark is \(selectedPlaceMark)")
  dismissLocationInputView { _ in
   let annotation = MKPointAnnotation()
   annotation.coordinate = selectedPlaceMark.coordinate
   self.removeAnnotationsAndOverlays()
   self.mapView.addAnnotation(annotation)
   self.mapView.selectAnnotation(annotation, animated: true)
   let destination = MKMapItem(placemark: selectedPlaceMark)
   self.generatePolyLine(toDestination: destination)
   self.isDestinationSelected.toggle()
   self.mapView.showAnnotations([annotation,self.mapView.userLocation], animated: true)
  }


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

 func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
  if let route = self.route {
   let polyline = route.polyline
   let lineRenderer = MKPolylineRenderer(polyline: polyline)
   lineRenderer.strokeColor = .black
   lineRenderer.lineWidth = 3
   return lineRenderer
  }
  return MKOverlayRenderer()
 }

}


 // MARK:  Extensions

private extension HomeViewController {
 func searchBy(naturalLanguageQuery : String, completion : @escaping ([MKPlacemark]) -> Void) {

  var results = [MKPlacemark]()
  let request = MKLocalSearch.Request()

  request.region = mapView.region
  request.naturalLanguageQuery = naturalLanguageQuery

  let search = MKLocalSearch(request: request)
  search.start { response , error in
   if let err = error {
    print("DEBUG: Error is \(err)")
    return
   }
   guard let response = response else { return }
   response.mapItems.forEach { item in  results.append(item.placemark) }
   completion(results)
  }
 }

 func generatePolyLine(toDestination destination : MKMapItem) {
  let request = MKDirections.Request()
  request.source = MKMapItem.forCurrentLocation()
  request.destination = destination
  request.transportType = .automobile
  let direction = MKDirections(request: request)
  direction.calculate { response, error in
   guard let response = response else { return }
   self.route = response.routes[0]
   guard let polyLine = self.route?.polyline else { return }
   self.mapView.addOverlay(polyLine)
  }
 }
}




