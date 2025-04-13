//
//  NewsListViewModel.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import Foundation
import Combine
import UIKit

/// ViewModel экрана списка новостей
final class NewsListViewModel: NSObject {

    // MARK: Published

    /// Номер текущей страницы
    @Published var pageNumber: Int = 1

    /// Текущая страница новостей
    @Published var news: [News] = []

    // MARK: Services

    /// Фабрика создания экранов приложения
    let factory: IModuleFactory

    /// Менеджер запросов
    private let getNewsRequestManager: IGetNewsRequestManager

    /// Загрузчик изображений
    private let imageLoader: IImageLoader

    // MARK: Private

    /// Количество новостей на странице
    private let newsOnPageCount = 20

    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: Init

    init(
        factory: IModuleFactory,
        getNewsRequestManager: IGetNewsRequestManager,
        imageLoader: IImageLoader
    ) {
        self.factory = factory
        self.getNewsRequestManager = getNewsRequestManager
        self.imageLoader = imageLoader
        super.init()
        binding()
    }

    func loadImage(_ url: String) async -> UIImage? {
        return await imageLoader.loadImage(url)
    }
}

// MARK: Private

private extension NewsListViewModel {

    func binding() {
        $pageNumber
            .flatMap({ (page: Int) in
                self.getNewsRequestManager.getNews(page: page, count: self.newsOnPageCount)
                    .catch({ error -> Just<NewsPage> in
                        print(error)
                        return Just(NewsPage(news: [], totalCount: 0))
                    })
                    .eraseToAnyPublisher()
            })
            .sink { [weak self] newsPage in
                self?.news.append(contentsOf: newsPage.news)
            }
            .store(in: &self.cancellableSet)
    }
}
