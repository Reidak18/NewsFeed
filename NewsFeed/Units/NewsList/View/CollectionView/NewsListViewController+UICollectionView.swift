//
//  NewsListViewController+UICollectionView.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import UIKit

// MARK: UICollectionViewDelegate

extension NewsListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsDetailsViewController = viewModel.factory.createNewsDetailsModule(
            news: viewModel.news[indexPath.row]
        )
        navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            if !isLoading {
                isLoading = true
                viewModel.pageNumber += 1
            }
        }
    }
}
