//
//  LocationManager.swift
//  Velib2
//
//  Created by Pierre on 19/06/2022.
//

import CoreLocation
import MapKit
import UIKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 48.856614, longitude: 2.3522219)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
}

// CLLocation :Les informations sur la latitude, la longitude et la trajectoire communiquées par le système
// demande de l'autorisation à l'utilisateur d'utiliser sa localisation: locationManager.authorizationStatus
// https://developer.apple.com/documentation/corelocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var lastLocation: CLLocation?
    @Published var locations: [Location] = []
    
    var completion: ((CLLocation?) -> (Void))?

    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    private var locationManager: CLLocationManager?

    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.startUpdatingLocation()
        } else {
            print("Show an alert letting know this is off and to go turn it on.")
        }
    }

    // switch locationManager.authorizationStatus{} cmd b : msg: switch must be exhaustive, fix
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted") // alert
        case .denied:
            print("Your have denied this app location permission. Go into settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    // localisation actuelle gps
    // Tells the delegate that new location data is available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MapDetails.defaultSpan)
            completion?(location)
        }
    }

}
