//
//  DogListingDI.swift
//  DogListing
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import EasyDi

public class DogListingDI: Assembly {
    public func getDogListing() -> UIViewController {
        createView()
    }

    private func createView() -> UIViewController {
        let storyboard = UIStoryboard(name: "DogListingViewController",
                                      bundle: Bundle(for: DogListingDI.self))
        let view = storyboard.instantiateInitialViewController() as! DogListingViewController
        return define(init: view) {
            $0.presenter = self.createPresenter()
            return $0
        }
    }

    private func createPresenter() -> DogListingPresenterProtocol {
        define(init: DogListingPresenter())
    }
}
