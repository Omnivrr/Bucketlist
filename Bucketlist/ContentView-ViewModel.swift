//
//  ContentView-ViewModel.swift
//  Bucketlist
//


import Foundation
import LocalAuthentication
import MapKit

// Extension of ContentView to define the ViewModel class
extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        // Published properties for managing map region, locations, selected place, and unlock status
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false

        // Path to save locations data
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        // Initializer to load locations data
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = [] // Initialize with empty array if decoding fails
            }
        }

        // Function to save locations data
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        // Function to add a new location
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation) // Add the new location to the array
            save() // Save the updated data
        }

        // Function to update an existing location
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location // Update the location in the array
                save() // Save the updated data
            }
        }

        // Function to authenticate and unlock the app
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true // Set isUnlocked to true on successful authentication
                        }
                    } else {
                        // Handle authentication error
                    }
                }
            } else {
                // Device does not support biometrics or biometrics are not set up
            }
        }
    }
}
