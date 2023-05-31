//
//  Theme.swift
//  StorySpark
//
//  Created by James Wolfe on 20/05/2023.
//

import Foundation

enum Theme: Decodable, Equatable, CaseIterable, Identifiable {
    
    // MARK: - Cases
    case courage
    case friendship
    case identity
    case family
    case loss
    case growingUp
    case anger
    case jealousy
    case love
    
    // MARK: - Variables
    var id: Int16 {
        switch self {
        case .courage:
            return 0
        case .friendship:
            return 1
        case .identity:
            return 2
        case .family:
            return 3
        case .loss:
            return 4
        case .growingUp:
            return 5
        case .anger:
            return 6
        case .jealousy:
            return 7
        case .love:
            return 8
        }
    }
    
    var title: String {
        switch self {
        case .courage:
            return "Courage"
        case .friendship:
            return "Friendship"
        case .identity:
            return "Identity"
        case .family:
            return "Family"
        case .loss:
            return "Loss and Grief"
        case .growingUp:
            return "Growing Up"
        case .anger:
            return "Anger"
        case .jealousy:
            return "Jealousy"
        case .love:
            return "Love"
        }
    }
}
