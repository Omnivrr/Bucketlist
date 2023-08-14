//
//  ContentView-ViewModel.swift
//  Bucketlist
//
//  Created by Bukhari Sani on 14/08/2023.
//

import Foundation
import MapKit


extension ContentView {
   @MainActor class ViewModel: ObservableObject {
       @Published mapRegion = MKCoordinateRegion(center:
       CLLocationCoordinate2D(latitude: 50, longitude: 0 ), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
       
       @Published locations = [Location]()
       
       @Published selectedPlace: Location?
        
    }
}
