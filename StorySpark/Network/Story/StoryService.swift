//
//  StoryService.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation

class StoryService: NetworkService {

    func create(story: Story) async throws {
        let story: Story = try await request(StoryAPI.create(story: story))
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                do {
                    try story.persist()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func read() throws -> [Story] {
        let stories: [PersistenStory] = try CoreDataService.shared.fetchEntities()
        let data: [Data] = stories.map {
            $0.dictionaryWithValues(forKeys: ["id"])
        }
        
    }
}
