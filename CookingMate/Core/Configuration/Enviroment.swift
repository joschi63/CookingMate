//
//  Enviroment.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import Foundation

enum Enviroment {
    static var baseURL: URL {
        // Try to read from Info.plist
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
           let url = URL(string: urlString), !urlString.isEmpty {
            return url
        }

        // Fallbacks for development and previews
        #if DEBUG
        // Detect Xcode previews to avoid crashes
        let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        if isPreview {
            print("[Enviroment] API_BASE_URL missing in Info.plist for Preview. Using fallback http://localhost:8080")
            return URL(string: "http://localhost:8080")!
        }
        print("[Enviroment] API_BASE_URL missing in Info.plist. Using debug fallback http://localhost:8080")
        return URL(string: "http://localhost:8080")!
        #else
        fatalError("API_BASE_URL not set or invalid in Info.plist")
        #endif
    }
}
