//
//  ModuleFactory.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import UIKit

/// Фабрика создания экранов приложения
protocol IModuleFactory {

    /// Создать экран списка новостей
    func createNewsListModule() -> UIViewController

    /// Создать экран с отображением новости целиком
    func createNewsDetailsModule(news: News) -> UIViewController
}

final class ModuleFactory: IModuleFactory {

    /// Зависимости проекта
    let dependencies: DependenciesContainer

    init(dependencies: DependenciesContainer) {
        self.dependencies = dependencies
    }

    func createNewsListModule() -> UIViewController {
        let viewModel = NewsListViewModel(
            factory: self,
            getNewsRequestManager: dependencies.getNewsRequestManager,
            imageLoader: dependencies.imageLoader
        )
        let viewController = NewsListViewController(viewModel: viewModel)
        return viewController
    }

    func createNewsDetailsModule(news: News) -> UIViewController {
        let viewModel = NewsDetailsViewModel(
            news: news,
            imageLoader: dependencies.imageLoader,
            factory: self
        )
        let viewController = NewsDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
