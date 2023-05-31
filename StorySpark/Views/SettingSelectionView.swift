//
//  SettingSelectionView.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import SwiftUI

struct SettingSelectionView: View {
    
    // MARK: - Variables
    @EnvironmentObject var story: Story
    @State var next = false
    
    // MARK: - Views
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(Setting.allCases) { setting in
                        Button(
                            action: {
                                story.setting = setting
                                next = true
                            },
                            label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(setting.title)
                                            .foregroundColor(.black)
                                            .font(.title2)
                                        Text(setting.description)
                                            .foregroundColor(.black)
                                            .font(.caption)
                                            .multilineTextAlignment(.leading)
                                    }
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .opacity(story.setting == setting ? 1 : 0)
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
            SynopsisView()
                .environmentObject(story)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { NotificationCenter.default.post(name: Story.cancelledNotification, object: nil) }, label: {
                    Text("Cancel")
                })
            }
        }
        .navigationTitle("Setting")
    }
}

struct SettingSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SettingSelectionView()
            .environmentObject(Story())
    }
}
