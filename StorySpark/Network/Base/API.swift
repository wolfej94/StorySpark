//
//  API.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation

public protocol API {

    // MARK: - Variables

    var url: URL { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var additionalHeaders: [String: String] { get }

}

extension API {

    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpBody = body
        if request.httpBody != nil {
            request.setValue("application/json", forHTTPHeaderField: "Encoding")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        additionalHeaders.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpMethod = method.rawValue
        return request
    }

}
