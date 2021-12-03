import Foundation
import SwiftUI

public class AppOpenTracker: ObservableObject {
    public static let shared = AppOpenTracker()
    
    public let lastOpenedVersion: String = UserDefaults.standard.string(forKey: "lastOpenedVersion") ?? ""
    public let lastOpenedBuild: String = UserDefaults.standard.string(forKey: "lastOpenedBuild") ?? ""
    
    public let currentVersion: String = Bundle.main.releaseVersionNumber ?? ""
    public let currentBuild: String = Bundle.main.buildVersionNumber ?? ""
    
    /// A flag that resembles wether this version was opened for the first time
    @Published public var versionFirstOpened: Bool = false
    
    /// A counter that keeps track of how often the app was opened before this session
    @Published public private(set) var countOfAppOpenedBefore: Int = UserDefaults.standard.integer(forKey: "appOpenedCount")
    
    /// A flag that resembles wether this is the first time the user opened the app
    @Published public var appIsFirstOpened: Bool = false
    
    private init() {
        appIsFirstOpened = countOfAppOpenedBefore == 0
        
        UserDefaults.standard.set(countOfAppOpenedBefore + 1, forKey: "appOpenedCount")
        
        if lastOpenedVersion != currentVersion {
            versionFirstOpened = true
            UserDefaults.standard.setValue(currentVersion, forKey: "lastOpenedVersion")
            UserDefaults.standard.setValue(currentBuild, forKey: "lastOpenedBuild")
        }
    }
}
