//
//  EditView.swift
//  Bucketlist
//
//  Created by Bukhari Sani on 13/08/2023.
//


import SwiftUI

struct EditView: View {
    // Enum representing different loading states for nearby places
    enum LoadingState {
        case loading, loaded, failed
    }

    // Environment property to dismiss the view
    @Environment(\.dismiss) var dismiss
    // Location to be edited
    var location: Location
    // Closure to save the edited location
    var onSave: (Location) -> Void

    // State properties to hold the current edited values
    @State private var name: String
    @State private var description: String

    // State properties to manage loading state and fetched pages
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Text fields for editing the place name and description
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }

                Section("Nearby…") {
                    // Display content based on loading state
                    switch loadingState {
                    case .loading:
                        Text("Loading…") // Display while loading nearby places
                    case .loaded:
                        // Display nearby places if loaded
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.") // Display if fetching failed
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                // Save button to save changes and dismiss view
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation) // Call the onSave closure
                    dismiss() // Dismiss the view
                }
            }
            .task {
                await fetchNearbyPlaces() // Fetch nearby places when view appears
            }
        }
    }

    // Initializer to set up initial values for editing
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    // Function to fetch nearby places using Wikipedia API
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded // Update loading state to loaded
        } catch {
            loadingState = .failed // Update loading state to failed on error
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}
