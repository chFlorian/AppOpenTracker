import Foundation
import SwiftUI

extension Bundle {
    public var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
    public var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}

public class AppOpenTracker: ObservableObject {
    public static let shared = AppOpenTracker()
    
    public let lastOpenedVersion: String = UserDefaults.standard.string(forKey: "lastOpenedVersion") ?? ""
    public let lastOpenedBuild: String = UserDefaults.standard.string(forKey: "lastOpenedBuild") ?? ""
    
    public let currentVersion: String = Bundle.main.releaseVersionNumber ?? ""
    public let currentBuild: String = Bundle.main.buildVersionNumber ?? ""
    
    @Published public var versionFirstOpened: Bool = false
    @Published public var countOfAppOpenedBefore: Int = UserDefaults.standard.integer(forKey: "appOpenedCount")
    
    private init() {
        UserDefaults.standard.set(countOfAppOpenedBefore + 1, forKey: "appOpenedCount")
        
        if lastOpenedVersion != currentVersion {
            versionFirstOpened = true
            UserDefaults.standard.setValue(currentVersion, forKey: "lastOpenedVersion")
            UserDefaults.standard.setValue(currentBuild, forKey: "lastOpenedBuild")
        }
    }
}
