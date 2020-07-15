//
//  DogListingInteractor.swift
//  DogListing
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import RxSwift
import DogProtocols

protocol DogListingInteractorProtocol {
    func loadDogs() -> Observable<[DogListingViewModel]>
}

class DogListingInteractor: DogListingInteractorProtocol {
    private let mediator: DogGlobalMediatorProtocol
    
    init(mediator: DogGlobalMediatorProtocol) {
        self.mediator = mediator
    }
    
    func loadDogs() -> Observable<[DogListingViewModel]> {
        let resultSubject = PublishSubject<[DogListingViewModel]>()
        mediator.getDogNetwork().loadDogs { result in
            switch result {
            case .success(let json):
                resultSubject.onNext(self.mapJSONToViewModels(json))
            case .failure(let error):
                resultSubject.onError(error)
            }
        }
        return resultSubject
    }
    
    private func mapJSONToViewModels(_ json: JSON) -> [DogListingViewModel] {
        guard let jsonString = json as? String else { return [] }
        let data = Data(jsonString.utf8)
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
            return json.map({ jsonObject in
                DogListingViewModel(id: jsonObject["id"]!,
                                    name: jsonObject["name"]!,
                                    imageURL: jsonObject["imageURL"]!)
            })
        } else {
            return []
        }
    }
}
