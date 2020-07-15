//
//  DogListingPresenter.swift
//  DogListing
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import Foundation
import RxSwift

protocol DogListingPresenterProtocol {
    var dogViewModelsObservable: Observable<[DogListingViewModel]> { get }
    func loadDogs()
}

class DogListingPresenter: DogListingPresenterProtocol {
    // MARK: - Outputs
    var dogViewModelsObservable: Observable<[DogListingViewModel]> {
        dogViewModelsSubject
            .observeOn(MainScheduler.instance)
    }
    // MARK: - Properties
    private let dogViewModelsSubject = PublishSubject<[DogListingViewModel]>()

    // MARK: - Actions
    func loadDogs() {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            let viewModels: [DogListingViewModel] = [
                .init(name: "Хаски", imageURL: "https://funik.ru/wp-content/uploads/2018/10/eb7e498b8bdcaedf840b.jpg"),
                .init(name: "Сиба-Ину", imageURL: "https://kotsobaka.com/wp-content/uploads/2018/07/siba1.jpeg"),
                .init(name: "Корги", imageURL: "https://lapkins.ru/upload/uf/b50/b50d4643a4f0e08fe678a227fbd49bdb.jpg")
            ]
            self?.dogViewModelsSubject.onNext(viewModels)
        }
    }
}
