//
//  DogProfileProtocols.swift
//  DogProtocols
//
//  Created by Pavel Vaitsikhouski on 7/14/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit

public typealias JSON = Any

public protocol DogProfileProtocol {
    var mediator: DogGlobalMediatorProtocol! { get }
    func getDogProfile(id: String) -> UIViewController
}

public protocol DogListingProtocol {
    var mediator: DogGlobalMediatorProtocol! { get }
    func getDogListing() -> UIViewController
}

public protocol AddDogProtocol {
    var mediator: DogGlobalMediatorProtocol! { get }
    func getAddDog() -> UIViewController
}

public protocol DogNetworkManagerProtocol {
    func loadDogs(completion: @escaping (Result<JSON, Error>) -> Void)
    func loadDog(id: String, completion: @escaping (Result<JSON, Error>) -> Void)
    func uploadDog(name: String, url: String, completion: @escaping (Result<String, Error>) -> Void)
}

public protocol DogGlobalMediatorProtocol {
    func getDogProfileProtocol() -> DogProfileProtocol
    func getDogListingProtocol() -> DogListingProtocol
    func getDogNetwork() -> DogNetworkManagerProtocol
}
