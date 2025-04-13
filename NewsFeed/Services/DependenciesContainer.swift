//
//  DependenciesContainer.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

/// Контейнер зависимостей приложений
final class DependenciesContainer {

    /// Базовый менеджер сетевых запросов
    let requestManager: IRequestManager = RequestManager()

    /// Загрузчик новостей
    lazy var getNewsRequestManager: IGetNewsRequestManager = GetNewsRequestManager(requestManager: requestManager)

    /// Загрузчик изображений
    lazy var imageLoader: IImageLoader = ImageLoader(requestManager: requestManager)
}
