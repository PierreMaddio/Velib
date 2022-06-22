//
//  MapViewModel.swift
//  Velib2
//
//  Created by Pierre on 18/06/2022.
//

import Foundation
import SwiftUI
import MapKit
import UIKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class MapViewModel: ObservableObject {
    
    @Published var locationManager = LocationManager()
    let service: VelibService = VelibService()
    
    // latitude: premier element du tableau coordinate[] .first
    // longitude: dernier element du tableau coordinate[] .last
    init() {
        locationManager.completion = { lastLocation in
            self.service.fetchData(long: "\(lastLocation?.coordinate.longitude ?? 0.0)", lat: "\(lastLocation?.coordinate.latitude ?? 0.0)") { velib in
                var newLocation: [Location] = []
                velib?.records?.forEach({ record in
                    let location = Location(name: record.fields?.name ?? "", coordinate: .init(latitude: record.geometry?.coordinates?.last ?? 0.0, longitude: record.geometry?.coordinates?.first ?? 0.0))
                    newLocation.append(location)
                })
                DispatchQueue.main.async {
                    self.locationManager.locations = newLocation
                }
            }
        }
    }
    
    
    
}
