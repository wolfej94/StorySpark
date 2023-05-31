//
//  Setting.swift
//  StorySpark
//
//  Created by James Wolfe on 20/05/2023.
//

import Foundation

enum Setting: Decodable, Equatable, CaseIterable, Identifiable {
    
    // MARK: - Cases
    case woodland
    case kingdom
    case space
    case underwater
    case farm
    case magicalSchool
    case imaginaryWorlds
    case fairyland
    case island
    case urban
    
    // MARK: - Variables
    var id: Int16 {
        switch self {
        case .woodland:
            return 0
        case .kingdom:
            return 1
        case .space:
            return 2
        case .underwater:
            return 3
        case .farm:
            return 4
        case .magicalSchool:
            return 5
        case .imaginaryWorlds:
            return 6
        case .fairyland:
            return 7
        case .island:
            return 8
        case .urban:
            return 9
        }
    }
    var title: String {
        switch self {
        case .woodland:
            return "Enchanted Woods"
        case .kingdom:
            return "Kingdom"
        case .space:
            return "Outer Space"
        case .underwater:
            return "Underwater"
        case .farm:
            return "Farm"
        case .magicalSchool:
            return "Magical School"
        case .imaginaryWorlds:
            return "Imaginary Worlds"
        case .fairyland:
            return "Fairyland"
        case .island:
            return "Island"
        case .urban:
            return "Urban"
        }
    }
    
    var description: String {
        switch self {
        case .woodland:
            return "A magical forest filled with talking animals, fairies, and mythical creatures."
        case .kingdom:
            return "An enchanting castle or a kingdom with princesses, knights, and magical adventures."
        case .space:
            return "Exploring the vastness of space, discovering planets, stars, and aliens."
        case .underwater:
            return "Delving into the depths of the ocean, encountering marine life, and embarking on underwater quests."
        case .farm:
            return "Discovering life on a farm, interacting with farm animals, and experiencing rural adventures."
        case .magicalSchool:
            return "Attending a special school for wizards, witches, or magical creatures."
        case .imaginaryWorlds:
            return "Journeying to imaginative realms filled with whimsical landscapes, creatures, and unique rules."
        case .fairyland:
            return "A world where fairies, pixies, and magical beings reside, full of enchantment and wonder."
        case .island:
            return "Exploring remote islands with hidden treasures, secret caves, and thrilling escapades."
        case .urban:
            return "Everyday city life with relatable characters and relatable experiences."
        }
    }
    
}
