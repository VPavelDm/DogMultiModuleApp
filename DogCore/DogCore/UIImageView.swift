//
//  UIImageView.swift
//  DogCore
//
//  Created by Pavel Vaitsikhouski on 7/14/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit

public enum ImageLoadingError: Error, LocalizedError {
    case defaultError
    case urlParse
    
    public var errorDescription: String? {
        switch self {
        case .defaultError:
            return "Ошибка загрузки фотографии"
        case .urlParse:
            return "Формат ссылки неверный"
        }
    }
}

public extension UIImageView {
    typealias CancelBlock = () -> Void

    func load(url: String, completion: @escaping (Error) -> Void) -> CancelBlock {
        guard let url = URL(string: url) else {
            completion(ImageLoadingError.urlParse)
            return {}
        }
        let session = URLSession.shared
        let request = session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                completion(ImageLoadingError.defaultError)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(ImageLoadingError.defaultError)
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        
        request.resume()
        return {
            request.cancel()
        }
    }
}
