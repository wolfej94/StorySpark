//
//  NotificationCenter+SwiftUI.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import SwiftUI

extension View {
    
    func onReceive(_ notification: Notification.Name, handler: @escaping (Notification) -> ()) -> some View {
        NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main, using: handler)
        return self
    }
    
}
