//
//  ThemeSelectionView.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import SwiftUI

struct ThemeSelectionView: View {
    
    // MARK: - Variables
    @EnvironmentObject var story: Story
    @State var next = false
    
    // MARK: - Views
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(Theme.allCases) { theme in
                        Button(
                            action: {
                                story.theme = theme
                                next = true
                            },
                            label: {
                                HStack {
                                    Text(theme.title)
                                        .foregroundColor(.black)
                                        .font(.title2)
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .opacity(story.theme == theme ? 1 : 0)
                                }
                                .padding(.horizontal)
                            }
                        )
                        Divider()
                    }
                }
            }
        }
        .padding(.top)
        .navigationDestination(isPresented: $next, destination: {
            SettingSelectionView()
                .environmentObject(story)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { NotificationCenter.default.post(name: Story.cancelledNotification, object: nil) }, label: {
                    Text("Cancel")
                })
            }
        }
        .navigationTitle("Theme")
    }
}

struct ThemeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSelectionView()
            .environmentObject(Story())
    }
}
