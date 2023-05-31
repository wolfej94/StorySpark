//
//  StoryAPI.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation

enum StoryAPI: API {
    
    // MARK: - Cases
    case create(story: Story)
    
    // MARK: - Variables
    var url: URL {
        switch self {
        case .create:
            return .init(string: "https://api.openai.com/v1/completions")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        }
    }
    
    var body: Data? {
        switch self {
        case .create(let story):
            let dictionary: [String: Any] = [
                "model": "text-davinci-003",
                "prompt": "A 5 minute story for a \(story.ageGroup.title)yo focused on the theme \(story.theme.title) with a \(story.setting.title) setting",
                "temperature": 1,
                "max_tokens": 600,
                "top_p": 1,
                "frequency_penalty": 0,
                "presence_penalty": 0
            ]
            return try? JSONSerialization.data(withJSONObject: dictionary)
        }
    }
    
    var additionalHeaders: [String : String] {
        return ["Authorization": Configuration.openAIAPIKey]
    }
    
    
}
