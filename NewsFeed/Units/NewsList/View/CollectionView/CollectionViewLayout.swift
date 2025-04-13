//
//  CollectionViewLayout.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import UIKit

// MARK: UICollectionViewLayout

extension NewsListViewController {

    func createCollectionViewLayout() -> UICollectionViewLayout {
        // Маленькие итемы
        let smallHorizontalItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        smallHorizontalItem.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)
        let smallVerticalItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        smallVerticalItem.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)

        // Средние итемы (как два маленьких)
        let verticalItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        verticalItem.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)
        let horizontalItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        horizontalItem.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)
        // Большой итем (как четыре маленьких)
        let bigItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2)
            )
        )
        bigItem.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)

        // Вертикальная группа маленьких итемов
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            ),
            subitems: [smallHorizontalItem]
        )
        // Горизонтальная группа маленьких итемов
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [smallVerticalItem]
        )

        // Всевозможные комбинации средних и групп маленьких итемов
        let verticalItemAndGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [verticalItem, verticalGroup]
        )
        let horizontalItemAndGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [horizontalItem, horizontalGroup]
        )
        let verticalGroupAndItem = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [verticalGroup, verticalItem]
        )
        let horizontalGroupAndItem = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [horizontalGroup, horizontalItem]
        )
        // Основная группа
        let mainGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(3.0)
            ),
            subitems: [
                verticalItemAndGroup,
                horizontalItemAndGroup,
                bigItem,
                horizontalGroupAndItem,
                verticalGroupAndItem,
            ]
        )
        let section = NSCollectionLayoutSection(group: mainGroup)
        section.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
