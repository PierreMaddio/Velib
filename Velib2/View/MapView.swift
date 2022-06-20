//
//  MapView.swift
//  Velib2
//
//  Created by Pierre on 18/06/2022.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        
        NavigationView {
            Map(coordinateRegion: $viewModel.locationManager.region, showsUserLocation: true, annotationItems: viewModel.locationManager.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        Image(systemName: "bicycle.circle")
                    }
                }
            }
            .accentColor(Color(.systemBlue))
            .onAppear {
                viewModel.locationManager.checkIfLocationServiceIsEnabled()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
