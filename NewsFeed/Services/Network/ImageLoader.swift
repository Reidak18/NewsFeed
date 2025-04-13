//
//  ImageLoader.swift
//  NewsFeed
//
//  Created by Nikita Lukyantsev on 12.04.2025.
//

import UIKit

/// Загрузчик изображений
protocol IImageLoader {

    /// Загрузить изображение по ссылке
    /// При ошибке возвращает пустой UIImage
    func loadImage(_ urlString: String) async -> UIImage
}

final class ImageLoader: IImageLoader {

    /// Менеджер запросов
    private let requestManager: IRequestManager

    /// Кеш изображений для избежания повторной загрузки
    private var cache = NSCache<NSString, UIImage>()

    init(requestManager: IRequestManager) {
        self.requestManager = requestManager
    }

    func loadImage(_ urlString: String) async -> UIImage {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        guard let url = URL(string: urlString) else {
            return UIImage()
        }
        let requestResult = await requestManager.sendRequest(url: url)
        switch requestResult {
        case .success(let data):
            let image = UIImage(data: data) ?? UIImage()
            cache.setObject(image, forKey: url.absoluteString as NSString)
            return image
        case .failure:
            return UIImage()
        }
    }
}
