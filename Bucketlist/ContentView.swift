//
//  ContentView.swift
//  Bucketlist
//
//  Created by Bukhari Sani on 09/08/2023.
//
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span:
        MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate:
                    CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)),
        ]
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
            MapMarker(coordinate: location.coordinate)
        }
            .ignoresSafeArea()
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
