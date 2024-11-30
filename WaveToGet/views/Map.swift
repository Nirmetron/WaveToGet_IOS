//
//  Map.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-06-04.
//
import UIKit
import SwiftUI
import GoogleMaps


class MapViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyACWpX2rPp191GkVY3MORTyoR98KlkRU6I")
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
  }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{
            return
        }
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
}
//class MapViewController: UIViewController {
//
//    var locationManager: CLLocationManager!
//
//    // Step 2.
//    var mapView: GMSMapView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        GMSServices.provideAPIKey("AIzaSyACWpX2rPp191GkVY3MORTyoR98KlkRU6I")
//
//        locationManager = CLLocationManager()
//        mapView = GMSMapView()
//
//        // Do any additional setup after loading the view.
//
//        // Step 3.
//        print(GMSServices.openSourceLicenseInfo())
//        // Initialize the location manager.
//        // Step 4.
//        GoogleMapsHelper.initLocationManager(locationManager, delegate: self)
//        // Create a map.
//        // Step 5.
//        GoogleMapsHelper.createMap(on: view, locationManager: locationManager, mapView: mapView)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Step 6.
//        mapView.clear()
//    }
//
//}

// Delegates to handle events for the location manager.
//extension MapViewController: CLLocationManagerDelegate {
//
//    // Handle incoming location events.
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        // Step 7.
//        GoogleMapsHelper.didUpdateLocations(locations, locationManager: locationManager, mapView: mapView)
//    }
//
//    // Handle authorization for the location manager.
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        // Step 8.
//        GoogleMapsHelper.handle(manager, didChangeAuthorization: status)
//    }
//
//    // Handle location manager errors.
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
//        print("Error: \(error)")
//    }
//}

struct Map: UIViewControllerRepresentable
{
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    
    // 3.
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
}

