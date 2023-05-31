//
//  Story.swift
//  StorySpark
//
//  Created by James Wolfe on 20/05/2023.
//

import Foundation
import SwiftUI
import CoreData

class Story: Decodable, Identifiable, Hashable, ObservableObject, Persistable {
    
    // MARK: - Variables
    let id: UUID
    var name: String!
    var content: String!
    var createdAt: Date!
    @Published var ageGroup: AgeGroup!
    @Published var theme: Theme!
    @Published var setting: Setting!
    
    var dictionary: [String : Any] {
        [
            "id": id.uuidString,
            "name": name ?? "",
            "content": content ?? "",
            "createdAt": createdAt ?? .init(),
            "ageGroup": ageGroup.id,
            "theme": theme.id,
            "setting": setting.id
        ]
    }
    
    static let createdNotification: Notification.Name = .init("story_created")
    static let cancelledNotification: Notification.Name = .init("story_cancelled")
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case content
        case createdAt
        case ageGroup
        case theme
        case setting
    }
    
    // MARK: Views
    var cell: some View {
        HStack {
            Text(name)
                .foregroundColor(.black)
                .font(.title2)
            Spacer()
        }
    }
    
    // MARK: - Initializers
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.ageGroup = try container.decodeIfPresent(AgeGroup.self, forKey: .ageGroup)
        self.theme = try container.decodeIfPresent(Theme.self, forKey: .theme)
        self.setting = try container.decodeIfPresent(Setting.self, forKey: .setting)
    }
    
    init(name: String? = nil, content: String? = nil, createdAt: Date? = nil, ageGroup: AgeGroup? = nil, theme: Theme? = nil, setting: Setting? = nil, length: TimeInterval? = nil) {
        self.id = .init()
        self.name = name
        self.content = content
        self.createdAt = createdAt
        self.ageGroup = ageGroup
        self.theme = theme
        self.setting = setting
    }
    
    // MARK: - Equatable
    static func == (lhs: Story, rhs: Story) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
    
}

extension Story {
    
    static var previewContent: Story {
        return .init(
            name: "Test Story",
            content: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            """,
            createdAt: .init(),
            ageGroup: .upToThree,
            theme: .courage,
            setting: .kingdom,
            length: 60 * 5
        )
    }
}
