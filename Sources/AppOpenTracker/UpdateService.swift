//
//  File.swift
//  
//
//  Created by Florian Schweizer on 03.12.21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
@available(macOS 12.0, *)
public class UpdateService {
    public enum Status: Equatable {
        case upToDate
        case updateAvailable(version: String, releaseNotes: String, storeURL: URL)
    }
    
    public static let shared = UpdateService()
    
    private let url: URL
    private let bundleIdentifier: String
    private let decoder: JSONDecoder = JSONDecoder()
    private let urlSession: URLSession
    
    public init(bundleIdentifier: String = Bundle.main.bundleIdentifier!, urlSession: URLSession = .shared) {
        url = URL(string: "https://itunes.apple.com/br/lookup?bundleId=\(bundleIdentifier)")!
        self.bundleIdentifier = bundleIdentifier
        self.urlSession = urlSession
    }
    
    public func getUpdateStatus() async throws -> Status {
        let (data, _) = try await urlSession.data(from: url)
        let response = try decoder.decode(AppMetadataResults.self, from: data)
        
        guard let metadata = response.results.first else {
            throw URLError(.badServerResponse)
        }
        
        if Bundle.main.releaseVersionNumber == metadata.version {
            return .upToDate
        } else {
            return .updateAvailable(version: metadata.version, releaseNotes: metadata.releaseNotes, storeURL: metadata.trackViewUrl)
        }
    }
}

// A list of App metadata with details around a given app.
struct AppMetadata: Codable {
    /// The URL pointing to the App Store Page.
    /// E.g: https://apps.apple.com/br/app/rocketsim-for-xcode/id1504940162?mt=12&uo=4
    let trackViewUrl: URL

    /// The current latest version available in the App Store.
    let version: String
    
    /// The latest release notes
    let releaseNotes: String
}

struct AppMetadataResults: Codable {
    let results: [AppMetadata]
}
