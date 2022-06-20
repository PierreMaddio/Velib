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

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var lastLocation: CLLocation?
    @Published var locations: [Location] = []
    
    var completion: ((CLLocation?) -> (Void))?

    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    private var locationManager: CLLocationManager?

    // make sure is on
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.startUpdatingLocation()
        } else {
            print("Show an alert letting know this is off and to go turn it on.")
        }
    }

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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MapDetails.defaultSpan)
            completion?(location)
        }
    }

}
