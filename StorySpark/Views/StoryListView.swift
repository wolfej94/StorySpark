//
//  StoryListView.swift
//  StorySpark
//
//  Created by James Wolfe on 20/05/2023.
//

import SwiftUI

struct StoryListView: View {
    
    // MARK: - Variables
    @State var stories: [Story]
    @State var showAddMenu = false
    private let storyService = StoryService()
    
    // MARK: - Actions
    @Sendable @MainActor func refresh() async {
        
    }
    
    // MARK: - Views
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(stories.sorted(by: { $0.createdAt < $1.createdAt })) { story in
                    NavigationLink(value: story, label: {
                        story.cell
                    })
                    Divider()
                }
                .navigationDestination(for: Story.self, destination: { story in
                    ReaderView(story: story)
                })
            }
            .padding()
        }
        .refreshable(action: refresh)
        .navigationTitle("Stories")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showAddMenu = true }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .onReceive(Story.createdNotification, handler: { _ in
            showAddMenu = false
            Task { await refresh() }
        })
        .onReceive(Story.cancelledNotification, handler: { _ in
            showAddMenu = false
        })
        .fullScreenCover(isPresented: $showAddMenu) {
            NavigationStack {
                AgeGroupSelectionView()
                    .environmentObject(Story())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StoryListView(stories: [.previewContent, .previewContent])
        }
    }
}
