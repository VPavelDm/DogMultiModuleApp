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
    var interactor: DogListingInteractorProtocol!
    private let disposeBag = DisposeBag()
    private var viewModels: [DogListingViewModel] = []
    private let dogViewModelsSubject = PublishSubject<[DogListingViewModel]>()

    // MARK: - Actions
    func loadDogs() {
        interactor.loadDogs()
            .subscribe(onNext: { viewModels in
                self.dogViewModelsSubject.onNext(viewModels)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Showing methods
    func showDogDetail(at index: Int) {
        let viewModel = viewModels[index]
        router.showDogDetailScreen(id: viewModel.id)
    }
}
