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
                        VStack(spacing: 20) {
                            Text(location.name)
                                .font(.title)
                            HStack(spacing: 2) {
                                Image(systemName: "bicycle")
                                Text("Nombre de vélos électriques disponibles")
                                Text(String(location.ebike))
                            }
                            HStack(spacing: 2) {
                                Image(systemName: "bicycle")
                                Text("Nombre de vélos mécaniques disponibles")
                                Text(String(location.mechanical))
                            }
                            Spacer()
                        }
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
