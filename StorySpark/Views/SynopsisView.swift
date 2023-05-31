//
//  SynopsisView.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import SwiftUI

struct SynopsisView: View {
    
    // MARK: - Variables
    let storyService = StoryService()
    @State var state: ViewState = .initial
    @State var next = false
    @EnvironmentObject var story: Story
    
    // MARK: - Actions
    func save() {
        state = .loading
        Task {
            do {
                try await storyService.create(story: story)
                next = true
            } catch {
                await MainActor.run {
                    self.state = .error(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Views
    var body: some View {
        VStack {
            description
            Spacer()
            Button(action: save, label: {
                HStack {
                    Spacer()
                    if state == .loading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Save")
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                .frame(height: 40)
                .background(Color.accentColor.clipShape(RoundedRectangle(cornerRadius: 5)))
            })
            .padding(.horizontal)
            if case .error(let message) = state {
                HStack {
                    Text(message)
                        .foregroundColor(.red)
                        .font(.caption)
                    Spacer()
                }
                    .padding(.horizontal)
            }
        }
        .padding(.top)
        .navigationTitle("Synopsis")
        .navigationDestination(isPresented: $next, destination: {
            SuccessView()
                .navigationBarHidden(true)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { NotificationCenter.default.post(name: Story.cancelledNotification, object: nil) }, label: {
                    Text("Cancel")
                })
            }
        }
    }
    
    var description: some View {
        Group {
            HStack {
                Text("Age Group")
                    .font(.caption)
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text(story.ageGroup.title)
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer()
            }
            .padding(.horizontal)
            Divider()
            HStack {
                Text("Theme")
                    .font(.caption)
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text(story.theme.title)
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer()
            }
            .padding(.horizontal)
            Divider()
            HStack {
                Text("Setting")
                    .font(.caption)
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text(story.setting.title)
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer()
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

struct SynopsisView_Previews: PreviewProvider {
    static var previews: some View {
        SynopsisView()
            .environmentObject(Story())
    }
}

extension SynopsisView {
    
    enum ViewState: Equatable {
        
        // MARK: - Cases
        case initial
        case loading
        case error(message: String)
    }
    
}
