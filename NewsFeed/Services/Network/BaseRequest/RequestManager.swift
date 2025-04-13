//
//  RequestManager.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import Foundation
import Combine

/// Менеджер по работе с запросами
protocol IRequestManager {

    /// Отправить сетевой запрос
    func sendRequest<T>(
        url: URL
    ) -> AnyPublisher<T, RequestError> where T: Decodable

    /// Отправить сетевой запрос
    func sendRequest(
        url: URL
    ) async -> Result<Data, RequestError>
}

final class RequestManager: IRequestManager {

    private let urlSession: URLSession

    private let decoder: JSONDecoder

    init() {
        urlSession = URLSession.shared
        decoder = JSONDecoder()
    }

    func sendRequest<T>(
        url: URL
    ) -> AnyPublisher<T, RequestError> where T: Decodable {
        return urlSession.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: T.self, decoder: decoder)
            .catch({ _ in Fail<T, RequestError>(error: .badRequest) })
            .eraseToAnyPublisher()
    }

    func sendRequest(
        url: URL
    ) async -> Result<Data, RequestError> {
        guard let data = try? await urlSession.data(from: url).0 else {
            return .failure(.badRequest)
        }
        return .success(data)
    }
}
