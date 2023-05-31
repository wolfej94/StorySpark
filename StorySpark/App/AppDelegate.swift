//
//  AppDelegate.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - Variables
    var stories: [Story] = [] {
        didSet {
            NotificationCenter.default.post(name: Self.loaded, object: nil)
        }
    }
    let storyService = StoryService()
    
    static let loaded: Notification.Name = .init("app_loaded")
    
    // MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.stories = (try? self.storyService.read()) ?? []
        _ = NetworkReachability.shared
        return true
    }
    
}
