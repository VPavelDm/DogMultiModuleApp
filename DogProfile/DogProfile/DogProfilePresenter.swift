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
    }
    // MARK: - Properties
    private let dogProfileSubject = PublishSubject<DogProfileViewModel>()
    // MARK: - Actions
    func loadDogProfile() {
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.dogProfileSubject.onNext(.init(name: "Хаски", imageURL: ""))
        }
    }
}
