//
//  FileManager-DocumentDirectory.swift
//  Bucketlist
//
//  Created by Bukhari Sani on 14/08/2023.
//

import Foundation

extension fileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path(0)
    }
}
