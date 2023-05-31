//
//  AgeGroup.swift
//  StorySpark
//
//  Created by James Wolfe on 20/05/2023.
//

import Foundation

enum AgeGroup: Decodable, Equatable, CaseIterable, Identifiable {
    
    // MARK: - Cases
    case upToThree
    case threeToFive
    case fiveToEight
    case eigthToEleven
    
    // MARK: - Variables
    var id: Int16 {
        switch self {
        case .upToThree:
            return 0
        case .threeToFive:
            return 1
        case .fiveToEight:
            return 2
        case .eigthToEleven:
            return 3
        }
    }
    
    var title: String {
        switch self {
        case .upToThree:
            return "> 3"
        case .threeToFive:
            return "3 - 5"
        case .fiveToEight:
            return "5 - 8"
        case .eigthToEleven:
            return "8 - 11"
        }
    }
}
