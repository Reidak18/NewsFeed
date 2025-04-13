//
//  NewsPage.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

/// Структура страницы новостей от сервера
struct NewsPage: Decodable, Equatable {

    /// Массив новостей
    let news: [News]

    /// Общее количество новостей
    let totalCount: Int
}

/// Структура отдельной новости
struct News: Decodable, Equatable {

    /// Идентификатор
    let id: Int

    /// Заголовок
    let title: String

    /// Описание
    let description: String

    /// Дата публикации
    let publishedDate: String

    /// Путь к новости
    let url: String

    /// Полная ссылка на новость
    let fullUrl: String

    /// Ссылка на изображение
    let titleImageUrl: String

    /// Категория
    let categoryType: String
}
