//
//  File.swift
//  
//
//  Created by Florian Schweizer on 03.12.21.
//

import Foundation

extension Bundle {
    public var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
    public var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
