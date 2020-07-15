//
//  AddDogPresenter.swift
//  AddDog
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import Foundation
import RxSwift

protocol AddDogPresenterProtocol {
    var activityIndicatorObservable: Observable<Bool> { get }
    var clearContentObservable: Observable<Bool> { get }
    func addDog(name: String, url: String)
}

class AddDogPresenter: AddDogPresenterProtocol {
    // MARK: - Outputs
    var activityIndicatorObservable: Observable<Bool> {
        activityIndicatorSubject
    }
    var clearContentObservable: Observable<Bool> {
        clearContentSubject
    }
    
    // MARK: - Properties
    var interactor: AddDogInteractorProtocol!
    private let disposeBag = DisposeBag()
    private let activityIndicatorSubject = PublishSubject<Bool>()
    private let clearContentSubject = PublishSubject<Bool>()
    
    // MARK: - Actions
    func addDog(name: String, url: String) {
        interactor.addDog(name: name, url: url)
            .do(onSubscribe: { [weak self] in
                self?.activityIndicatorSubject.onNext(true)
            })
            .subscribe(onNext: { [weak self] _ in
                self?.activityIndicatorSubject.onNext(false)
                self?.clearContentSubject.onNext(true)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
