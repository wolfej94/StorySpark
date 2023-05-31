//
//  ErrorResponse.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation

internal struct ErrorResponse: Decodable {

    let success: Bool
    let message: String

    // MARK: - Initializers

    enum CodingKeys: CodingKey {
        case success
        case message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.message = try container.decode(String.self, forKey: .message)
    }

}
