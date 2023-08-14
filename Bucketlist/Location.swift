//
//  Location.swift
//  Bucketlist
//
//  Created by Bukhari Sani on 12/08/2023.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    // A computed property to convert latitude and longitude to a CLLocationCoordinate2D object
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // A static property providing an example location for testing
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis", latitude: 51.501, longitude: -0.141)
    
    // Equatable conformance to compare locations based on their IDs
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

/* Identifiable: The Location struct conforms to the Identifiable protocol, which means it has a property named id of type UUID. This is used to uniquely identify instances of Location.
 
 Codable: The Location struct also conforms to the Codable protocol, which enables instances of this struct to be encoded into and decoded from data formats like JSON.

 Equatable: The Location struct conforms to the Equatable protocol, which allows you to compare two instances of Location for equality. In this case, the comparison is based on the equality of their id properties.

 id, name, description, latitude, and longitude: These are properties that store the information about a location, including its identifier, name, description, and geographical coordinates.

 coordinate: This is a computed property that returns a CLLocationCoordinate2D object using the latitude and longitude properties. This can be useful when interacting with map-related APIs that require coordinate information.

 example: This is a static property that provides an example instance of Location. It can be used for testing and demonstration purposes.

 == operator function: This function defines how two Location instances are compared for equality. In this case, it compares the id properties of the two instances.*/
