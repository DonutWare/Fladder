//
//  DirectoryBookmark.swift
//  Runner
//
//  Created by Jop Knaapen on 15/11/2025.
//

import Foundation
import AppKit

class DirectoryBookmarkImplementation: DirectoryBookmark {
    private var activatedURLs = [String: URL]()
    
    func saveDirectory(key: String, path: String) throws {
        try saveFreshBookmark(for: URL(fileURLWithPath: path), key: key)
    }
    
    func resolveDirectory(key: String) throws -> String? {
        let defaults = UserDefaults.standard

        guard let bookmarkData = defaults.data(forKey: key) else {
            return nil
        }

        var isStale = false

        let url = try URL(
            resolvingBookmarkData: bookmarkData,
            options: [.withSecurityScope],
            relativeTo: nil,
            bookmarkDataIsStale: &isStale
        )

        if isStale {
            print("Bookmark was stale, needs updating.")
            try saveFreshBookmark(for: url, key: key)
        }

        if !url.startAccessingSecurityScopedResource() {
            print("Failed to start security scope.")
        }
        
        activatedURLs.updateValue(url, forKey: key)
        return url.path
    }
    
    func closeDirectory(key: String) throws {
        guard let url = activatedURLs[key] else {
                    print("No active URL for key '\(key)' to stop.")
                    return
                }
        url.stopAccessingSecurityScopedResource()
        activatedURLs.removeValue(forKey: key)
        print("Stopped security scope for key: \(key)")
    }

    private func saveFreshBookmark(for url: URL, key: String) throws {
        let bookmark = try url.bookmarkData(
            options: [.withSecurityScope],
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )

        UserDefaults.standard.set(bookmark, forKey: key)
    }
}
