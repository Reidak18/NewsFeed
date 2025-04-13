//
//  GetNewsRequestManager.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import Foundation
import Combine

/// Менеджер запросов для получения новостей
protocol IGetNewsRequestManager {

    /// Получить новости
    /// - Parameters:
    ///     - page - номер страницы
    ///     - count: количество новостей на странице
    func getNews(
        page: Int,
        count: Int
    ) -> AnyPublisher<NewsPage, RequestError>
}

final class GetNewsRequestManager: IGetNewsRequestManager {

    private let requestManager: IRequestManager

    init(requestManager: IRequestManager) {
        self.requestManager = requestManager
    }

    func getNews(
        page: Int,
        count: Int
    ) -> AnyPublisher<NewsPage, RequestError> {
        guard let url = URL(string: NetworkApi.newsApi.rawValue) else {
            return Fail<NewsPage, RequestError>(error: .badURL).eraseToAnyPublisher()
        }
        let fullUrl = url.appendingPathComponent(String(page)).appendingPathComponent(String(count))
        return requestManager.sendRequest(url: fullUrl)
    }
}
