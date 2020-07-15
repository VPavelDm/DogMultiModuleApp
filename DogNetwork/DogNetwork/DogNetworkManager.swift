//
//  DogNetworkManager.swift
//  DogNetwork
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import Foundation
import DogProtocols

public class DogNetworkManager: DogNetworkManagerProtocol {
    public func loadDogs(completion: @escaping (Result<JSON, Error>) -> Void) {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.asyncAfter(deadline: .now() + .seconds(1)) { [viewModelsJSON] in
            completion(.success(viewModelsJSON))
        }
    }
    
    public func loadDog(id: String, completion: @escaping (Result<JSON, Error>) -> Void) {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.asyncAfter(deadline: .now() + .seconds(1)) { [weak self, viewModelsJSON] in
            if let array = self?.mapJSONToArray(viewModelsJSON) {
                for item in array {
                    if item["id"] == id {
                        completion(.success(item))
                        return
                    }
                }
            }
        }
    }
    
    private func mapJSONToArray(_ json: JSON) -> [[String: String]]? {
        guard let jsonString = json as? String else { return [] }
        let data = Data(jsonString.utf8)
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]]
    }
    
    private let viewModelsJSON: String = """
[
  {
    "id": "1",
    "name": "Хаски",
    "imageURL": "https://funik.ru/wp-content/uploads/2018/10/eb7e498b8bdcaedf840b.jpg"
  },
  {
    "id": "2",
    "name": "Сиба-Ину",
    "imageURL": "https://kotsobaka.com/wp-content/uploads/2018/07/siba1.jpeg"
  },
  {
    "id": "3",
    "name": "Корги",
    "imageURL": "https://lapkins.ru/upload/uf/b50/b50d4643a4f0e08fe678a227fbd49bdb.jpg"
  }
]
"""
}
