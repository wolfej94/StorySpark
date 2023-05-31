//
//  NetworkService.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation


import Foundation

public class NetworkService: NSObject {

    // MARK: - Variables

    private let decoder: JSONDecoder
    private let interceptor: NetworkInterceptor

    private lazy var session: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: URLSessionConfiguration.default)
    }()

    // MARK: - Initializers

    public init(decoder: JSONDecoder = .init(), interceptor: NetworkInterceptor? = nil) {
        self.decoder = decoder
        self.interceptor = interceptor ?? .init(intercept: { return $0 })
    }

    // MARK: - Utilities

    public func request<T: Decodable>(_ api: API) async throws -> T {
        guard NetworkReachability.shared.currentStatus == . satisfied else { throw NetworkError.networkUnavailable }
        return try await withCheckedThrowingContinuation { continuation in
            var request = interceptor.intercept(api.request)
            session.dataTask(with: request) { [weak self] data, response, error in
                do {
                    guard let self = self else { return }
                    guard error == nil else { throw error! }
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        throw NetworkError(code: nil, errorDescription: "Invalid Response Data")
                    }
                    switch response.statusCode {
                    case 400...499:
                        if let errorResponse = try? self.decoder.decode(ErrorResponse.self, from: data) {
                            throw NetworkError(code: response.statusCode, errorDescription: errorResponse.message)
                        } else {
                            throw NetworkError.unknown
                        }
                    default:
                        continuation.resume(returning: try self.decoder.decode(T.self, from: data))
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            }.resume()
        }
    }

    public func request(_ api: API) async throws {
        guard NetworkReachability.shared.currentStatus == . satisfied else { throw NetworkError.networkUnavailable }
        return try await withCheckedThrowingContinuation { continuation in
            var request = interceptor.intercept(api.request)
            session.dataTask(with: request) { [weak self] data, response, error in
                do {
                    guard let self = self else { return }
                    guard error == nil else { throw error! }
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        throw NetworkError.invalidResponse
                    }
                    switch response.statusCode {
                    case 400...499:
                        if let errorResponse = try? self.decoder.decode(ErrorResponse.self, from: data) {
                            throw NetworkError(code: response.statusCode, errorDescription: errorResponse.message)
                        } else {
                            throw NetworkError.unknown
                        }
                    default:
                        continuation.resume(returning: ())
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            }.resume()
        }
    }

}
