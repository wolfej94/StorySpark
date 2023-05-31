//
//  ReaderView.swift
//  StorySpark
//
//  Created by James Wolfe on 20/05/2023.
//

import SwiftUI

struct ReaderView: View {
    
    // MARK: - Variables
    let story: Story
    
    // MARK: - Views
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Text(story.content)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
            }
        }
        .padding([.horizontal, .top])
        .navigationTitle(story.name)
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView(story: .previewContent)
    }
}
