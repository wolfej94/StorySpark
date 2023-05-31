//
//  NetworkError.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation

internal struct NetworkError: LocalizedError {

    // MARK: - Static Variables

    static let invalidResponse: NetworkError = .init(
        code: nil,
        errorDescription: "Invalid Response"
    )
    static let unknown: NetworkError = .init(
        code: nil,
        errorDescription: "Unknown Error"
    )
    static let networkUnavailable: NetworkError = .init(
        code: nil,
        errorDescription: "Network Unavailable"
    )
    
    // MARK: - Variables
    var code: Int?
    var errorDescription: String?

}
