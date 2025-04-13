//
//  NewsDetailsViewController.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import UIKit

/// View экрана с полным описанием новости
final class NewsDetailsViewController: UIViewController {

    let viewModel: NewsDetailsViewModel

    private let inputDateFormatter = DateFormatter()
    private let outputDateFormatter = DateFormatter()

    // MARK: UI Elements

    /// Скролл
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    /// Основной стек
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    /// Картинка новости
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        Task {
            imageView.image = await viewModel.loadImage(viewModel.news.titleImageUrl)
            guard let size = imageView.image?.size else { return }
            let aspectRatio = size.height / size.width
            NSLayoutConstraint.activate(
                [
                    imageView.heightAnchor.constraint(
                        equalTo: imageView.widthAnchor,
                        multiplier: aspectRatio
                    )
                ]
            )
        }
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let size = imageView.image?.size else { return imageView }
        let aspectRatio = size.height / size.width
        NSLayoutConstraint.activate(
            [
                imageView.heightAnchor.constraint(
                    equalTo: imageView.widthAnchor,
                    multiplier: aspectRatio
                )
            ]
        )
        return imageView
    }()

    /// Заголовок
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.news.title
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Описание
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.news.description
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Дата публикации
    private lazy var publishDateLabel: UILabel = {
        let label = UILabel()
        if let date = inputDateFormatter.date(from: viewModel.news.publishedDate) {
            let formattedDateStr = outputDateFormatter.string(from: date)
            label.text = "Опубликовано: \(formattedDateStr)"
        }
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Кнопка открытия подробностей
    private lazy var urlButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Читать дальше...", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(openUrl), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    /// Категория
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория: \(viewModel.news.categoryType)"
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Init

    init(viewModel: NewsDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        outputDateFormatter.dateFormat = "dd.MM.yyyy"
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

private extension NewsDetailsViewController {

    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        [
            titleLabel,
            descriptionLabel,
            imageView,
            urlButton,
            publishDateLabel,
            categoryLabel
        ].forEach(stackView.addArrangedSubview(_:))
    }

    func layoutView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    @objc
    func openUrl() {
        guard let url = URL(string: viewModel.news.fullUrl) else { return }
        UIApplication.shared.open(url)
    }
}
