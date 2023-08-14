//
//  FileManager-DocumentDirectory.swift
//  Bucketlist
//
//  Created by Bukhari Sani on 14/08/2023.
//

import Foundation

extension FileManager {
    // Extension to provide easy access to the documents directory
    
    static var documentsDirectory: URL {
        // Computed property that returns the URL of the documents directory
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // Get the URLs for the document directory in the user's domain
        
        return paths[0]
        // Return the first URL from the list of document directory URLs
    }
}
