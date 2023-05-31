//
//  StorySparkApp.swift
//  StorySpark
//
//  Created by James Wolfe on 20/05/2023.
//

import SwiftUI



@main
struct StorySparkApp: App {
    
    // MARK: - Variables
    @State var stories: [Story] = []
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Views
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if stories.count > 0 {
                    StoryListView(stories: stories)
                }
            }
            .onReceive(AppDelegate.loaded) { _ in
                self.stories = delegate.stories
            }
        }
    }
}
