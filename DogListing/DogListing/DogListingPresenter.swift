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
    func showDogDetail(at index: Int)
}

class DogListingPresenter: DogListingPresenterProtocol {
    // MARK: - Outputs
    var dogViewModelsObservable: Observable<[DogListingViewModel]> {
        dogViewModelsSubject
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] viewModels in
                self?.viewModels = viewModels
            })
    }
    // MARK: - Properties
    var router: DogListingRouterProtocol!
    private var viewModels: [DogListingViewModel] = []
    private let dogViewModelsSubject = PublishSubject<[DogListingViewModel]>()

    // MARK: - Actions
    func loadDogs() {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            let viewModels: [DogListingViewModel] = [
                .init(id: "1",
                      name: "Хаски",
                      imageURL: "https://funik.ru/wp-content/uploads/2018/10/eb7e498b8bdcaedf840b.jpg"),
                .init(id: "2",
                      name: "Сиба-Ину",
                      imageURL: "https://kotsobaka.com/wp-content/uploads/2018/07/siba1.jpeg"),
                .init(id: "3",
                      name: "Корги",
                      imageURL: "https://lapkins.ru/upload/uf/b50/b50d4643a4f0e08fe678a227fbd49bdb.jpg")
            ]
            self?.dogViewModelsSubject.onNext(viewModels)
        }
    }
    
    // MARK: - Showing methods
    func showDogDetail(at index: Int) {
        let viewModel = viewModels[index]
        router.showDogDetailScreen(id: viewModel.id)
    }
}
