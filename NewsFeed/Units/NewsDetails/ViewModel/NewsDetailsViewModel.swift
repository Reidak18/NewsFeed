//
//  NewsDetailsViewModel.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import UIKit

/// ViewModel экрана с полным описанием новости
final class NewsDetailsViewModel {

    /// Текущая новость
    let news: News

    // MARK: Services

    /// Загрузчик изображений
    private let imageLoader: IImageLoader

    /// Фабрика создания экранов приложения
    let factory: IModuleFactory

    init(
        news: News,
        imageLoader: IImageLoader,
        factory: IModuleFactory
    ) {
        self.news = news
        self.imageLoader = imageLoader
        self.factory = factory
    }

    func loadImage(_ url: String) async -> UIImage? {
        return await imageLoader.loadImage(url)
    }
}
