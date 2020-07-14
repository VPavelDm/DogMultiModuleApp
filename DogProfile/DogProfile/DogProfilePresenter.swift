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
    let id: String
    // MARK: - Initializers
    init(id: String) {
        self.id = id
    }
    // MARK: - Actions
    func loadDogProfile() {
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.dogProfileSubject.onNext(.init(name: "Хаски",
                                                 imageURL: "https://avatars.mds.yandex.net/get-pdb/2883913/16bbcb45-3368-428c-baf8-142afb114820/s1200?webp=false"))
        }
    }
}
