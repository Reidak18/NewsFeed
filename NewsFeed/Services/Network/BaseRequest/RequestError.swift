//
//  RequestError.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

/// Возможные ошибки при отправке запросов
enum RequestError: Error {

    /// Неверная ссылка
    case badURL

    /// Ошибка с запросом
    case badRequest
}
