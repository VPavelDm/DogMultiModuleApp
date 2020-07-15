//
//  DogProfilePresenter.swift
//  DogProfile
//
//  Created by Pavel Vaitsikhouski on 7/14/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import Foundation
import RxSwift

protocol DogProfilePresenterProtocol {
    var dogProfileObservable: Observable<DogProfileViewModel> { get }
    func loadDogProfile()
}

class DogProfilePresenter: DogProfilePresenterProtocol {
    // MARK: - Outputs
    var dogProfileObservable: Observable<DogProfileViewModel> {
        dogProfileSubject
            .observeOn(MainScheduler.instance)
    }
    // MARK: - Properties
    var interactor: DogProfileInteractorProtocol!
    private let disposeBag = DisposeBag()
    private let dogProfileSubject = PublishSubject<DogProfileViewModel>()
    let id: String
    // MARK: - Initializers
    init(id: String) {
        self.id = id
    }
    // MARK: - Actions
    func loadDogProfile() {
        interactor.loadDog(id: id)
            .subscribe(onNext: { [weak self] viewModel in
                self?.dogProfileSubject.onNext(viewModel)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
