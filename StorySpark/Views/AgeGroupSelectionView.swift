//
//  AgeGroupSelectionView.swift
//  StorySpark
//
//  Created by James Wolfe on 20/05/2023.
//

import SwiftUI

struct AgeGroupSelectionView: View {
    
    // MARK: - Variables
    @EnvironmentObject var story: Story
    @State var next = false
    
    // MARK: - Views
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(AgeGroup.allCases) { ageGroup in
                        Button(
                            action: {
                                story.ageGroup = ageGroup
                                next = true
                            },
                            label: {
                                HStack {
                                    Text(ageGroup.title)
                                        .foregroundColor(.black)
                                        .font(.title2)
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .opacity(story.ageGroup == ageGroup ? 1 : 0)
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
            ThemeSelectionView()
                .environmentObject(story)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { NotificationCenter.default.post(name: Story.cancelledNotification, object: nil) }, label: {
                    Text("Cancel")
                })
            }
        }
        .navigationTitle("Age Group")
    }
}

struct AgeGroupSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AgeGroupSelectionView()
            .environmentObject(Story())
    }
}
