//
//  DogProfileDI.swift
//  DogProfile
//
//  Created by Pavel Vaitsikhouski on 7/14/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import EasyDi
import DogProtocols

public class DogProfileDI: Assembly, DogProfileProtocol {
    public func getDogProfile(id: String) -> UIViewController {
        createView(id: id)
    }

    private func createView(id: String) -> UIViewController {
        define(init: DogProfileViewController()) {
            $0.presenter = self.createPresenter(id: id)
            return $0
        }
    }

    private func createPresenter(id: String) -> DogProfilePresenterProtocol {
        define(init: DogProfilePresenter(id: id))
    }
}
