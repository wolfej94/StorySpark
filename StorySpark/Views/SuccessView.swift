//
//  SuccessView.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import SwiftUI

struct SuccessView: View {
    
    // MARK: - Views
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            Text("Story Created")
                .font(.largeTitle)
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                NotificationCenter.default.post(name: Story.createdNotification, object: nil)
            })
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
