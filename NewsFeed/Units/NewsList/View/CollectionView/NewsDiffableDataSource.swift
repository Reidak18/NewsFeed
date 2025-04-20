//
//  NewsDiffableDataSource.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 20.04.2025.
//

import UIKit

/// Реализация UICollectionViewDiffableDataSource для ленты новостей
final class NewsDiffableDataSource: UICollectionViewDiffableDataSource<NewsSection, NewsCellItem> {

    /// Добавить новые элементы в CollectionView
    func addItems(_ items: [NewsCellItem], animated: Bool = true) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        apply(snapshot, animatingDifferences: animated)
    }
}
