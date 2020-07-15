//
//  DogProfileProtocols.swift
//  DogProtocols
//
//  Created by Pavel Vaitsikhouski on 7/14/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit

public protocol DogProfileProtocol {
    var mediator: DogGlobalMediatorProtocol! { get }
    func getDogProfile(id: String) -> UIViewController
}

public protocol DogListingProtocol {
    var mediator: DogGlobalMediatorProtocol! { get }
    func getDogListing() -> UIViewController
}

public protocol DogGlobalMediatorProtocol {
    func getDogProfileProtocol() -> DogProfileProtocol
    func getDogListingProtocol() -> DogListingProtocol
}
