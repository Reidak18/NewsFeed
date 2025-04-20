//
//  NewsCellItem.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 20.04.2025.
//

/// Объект ячейки новостей в CollectionView
struct NewsCellItem: Hashable {

    /// Идентификатор
    let id: Int
}

/// Секция CollectionView
enum NewsSection: Hashable {

    /// Основная секция
    case main
}
