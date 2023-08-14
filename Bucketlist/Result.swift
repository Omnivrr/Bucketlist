//
//  Result.swift
//  Bucketlist
//
//  Created by Bukhari Sani on 14/08/2023.
//

import Foundation


struct Result: Codable {
    // Codable struct representing the top-level structure of the API response
    
    let query: Query
    // Property to hold the Query object, which contains pages
}

struct Query: Codable {
    // Codable struct representing the "query" portion of the API response
    
    let pages: [Int: Page]
    // Dictionary property holding page IDs as keys and Page objects as values
}

struct Page: Codable, Comparable {
    // Codable struct representing individual pages from the API response
    // Also, conforms to the Comparable protocol for sorting
    
    let pageid: Int
    // Property to hold the unique page ID
    
    let title: String
    // Property to hold the title of the page
    
    let terms: [String: [String]]?
    // Optional property containing terms, which might include a description
    
    var description: String {
        // Computed property to provide a description, or default if not available
        terms?["description"]?.first ?? "No further information"
    }

    static func <(lhs: Page, rhs: Page) -> Bool {
        // Implementing Comparable protocol for sorting Pages based on title
        lhs.title < rhs.title
    }
}

