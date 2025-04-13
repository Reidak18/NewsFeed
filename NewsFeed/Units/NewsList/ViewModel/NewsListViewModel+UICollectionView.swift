//
//  NewsListViewModel+UICollectionView.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import UIKit

// MARK: UICollectionViewDataSource

extension NewsListViewModel: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewsCell.identificator,
            for: indexPath
        ) as? NewsCell else {
            return UICollectionViewCell()
        }
        let news = news[indexPath.row]
        cell.setContent(title: "Загрузка...", image: UIImage(named: "loading"))
        Task {
            let image = await loadImage(news.titleImageUrl)
            DispatchQueue.main.async {
                guard cell === collectionView.cellForItem(at: indexPath) else { return }
                cell.setContent(title: news.title, image: image)
            }
        }
        return cell
    }
}
