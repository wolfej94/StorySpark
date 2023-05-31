//
//  Configuration.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation

class Configuration {
    
    static let openAIAPIKey: String = Bundle.main.object(forInfoDictionaryKey: "OPEN_AI_API_KEY") as! String
    
}
