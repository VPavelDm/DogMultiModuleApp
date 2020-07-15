//
//  AddDogInteractor.swift
//  AddDog
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import Foundation
import RxSwift
import DogProtocols

protocol AddDogInteractorProtocol {
    func addDog(name: String, url: String) -> Observable<Void>
}

class AddDogInteractor: AddDogInteractorProtocol {
    private let manager: DogNetworkManagerProtocol
    
    init(mediator: DogGlobalMediatorProtocol) {
        self.manager = mediator.getDogNetwork()
    }
    
    func addDog(name: String, url: String) -> Observable<Void> {
        let resultSubject = PublishSubject<Void>()
        manager.uploadDog(name: name, url: url) { result in
            switch result {
            case .success:
                resultSubject.onNext(Void())
            case .failure(let error):
                resultSubject.onError(error)
            }
        }
        return resultSubject
    }
}
