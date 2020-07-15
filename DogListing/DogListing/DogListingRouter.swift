//
//  DogListingRouter.swift
//  DogListing
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit
import DogProtocols

protocol DogListingRouterProtocol {
    func showDogDetailScreen(id: String)
}

class DogListingRouter: DogListingRouterProtocol {
    private let viewController: UIViewController
    private let mediator: DogGlobalMediatorProtocol
    
    init(viewController: UIViewController, mediator: DogGlobalMediatorProtocol) {
        self.viewController = viewController
        self.mediator = mediator
    }
    
    func showDogDetailScreen(id: String) {
        let dogDetail = mediator.getDogProfileProtocol().getDogProfile(id: id)
        viewController.navigationController?.pushViewController(dogDetail, animated: true)
    }
}
