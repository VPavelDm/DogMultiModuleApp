//
//  DogProfileInteractor.swift
//  DogProfile
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import Foundation
import RxSwift
import DogProtocols

protocol DogProfileInteractorProtocol {
    func loadDog(id: String) -> Observable<DogProfileViewModel>
}

class DogProfileInteractor: DogProfileInteractorProtocol {
    private let mediator: DogGlobalMediatorProtocol
    private let dogNetworkManager: DogNetworkManagerProtocol
    
    init(mediator: DogGlobalMediatorProtocol) {
        self.mediator = mediator
        self.dogNetworkManager = mediator.getDogNetwork()
    }

    func loadDog(id: String) -> Observable<DogProfileViewModel> {
        let resultSubject = PublishSubject<DogProfileViewModel>()
        dogNetworkManager.loadDog(id: id) { result in
            switch result {
            case .success(let json):
                if let viewModel = self.mapJSONToViewModel(json) {
                    resultSubject.onNext(viewModel)
                }
            case .failure(let error):
                resultSubject.onError(error)
            }
        }
        return resultSubject
    }
    
    private func mapJSONToViewModel(_ json: JSON) -> DogProfileViewModel? {
        guard let json = json as? [String: String] else { return nil }
        return DogProfileViewModel(name: json["name"]!,
                                   imageURL: json["imageURL"]!)
    }
}
