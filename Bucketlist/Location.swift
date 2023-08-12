//
//  Location.swift
//  Bucketlist
//
//  Created by Bukhari Sani on 12/08/2023.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
