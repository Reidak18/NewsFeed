//
//  NewsListViewController.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import UIKit
import Combine

/// View экрана списка новостей
final class NewsListViewController: UIViewController {

    let viewModel: NewsListViewModel

    private var cancellableSet: Set<AnyCancellable> = []

    var isLoading: Bool = false

    // MARK: UI Elements

    /// Лента новостей
    private lazy var collectionView: UICollectionView = {
        let spacing: CGFloat = 5
        let inset: CGFloat = 10
        let cellInRow: CGFloat = 2
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        cv.dataSource = viewModel
        cv.delegate = self
        cv.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identificator)
        cv.backgroundColor = .systemBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    // MARK: Init

    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        layoutView()
    }
}

// MARK: Private

private extension NewsListViewController {

    func setupView() {
        navigationItem.backButtonTitle = "Назад"
        view.addSubview(collectionView)
    }

    func layoutView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func binding() {
        viewModel.$news.sink { [weak self] page in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.collectionView.reloadData()
            }
        }
        .store(in: &cancellableSet)
    }
}
