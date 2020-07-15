//
//  DogListingDI.swift
//  DogListing
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import EasyDi
import DogProtocols

public class DogListingDI: Assembly, DogListingProtocol {
    public var mediator: DogGlobalMediatorProtocol!
    
    public func getDogListing() -> UIViewController {
        createView()
    }

    private func createView() -> UIViewController {
        let storyboard = UIStoryboard(name: "DogListingViewController",
                                      bundle: Bundle(for: DogListingDI.self))
        let view = storyboard.instantiateInitialViewController() as! DogListingViewController
        return define(init: view) {
            $0.presenter = self.createPresenter(view: $0)
            return $0
        }
    }

    private func createPresenter(view: UIViewController) -> DogListingPresenterProtocol {
        define(init: DogListingPresenter()) {
            $0.router = self.createRouter(view: view)
            return $0
        }
    }
    
    private func createRouter(view: UIViewController) -> DogListingRouterProtocol {
        define(init: DogListingRouter(viewController: view, mediator: self.mediator))
    }
}
