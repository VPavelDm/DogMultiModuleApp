//
//  AddDogDI.swift
//  AddDog
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import Foundation
import EasyDi
import DogProtocols

public class AddDogDI: Assembly, AddDogProtocol {
    public var mediator: DogGlobalMediatorProtocol!
    public func getAddDog() -> UIViewController {
        createView()
    }
    
    public func createView() -> UIViewController {
        let storyboard = UIStoryboard(name: "AddDogViewController",
                                      bundle: Bundle(for: AddDogDI.self))
        let view = storyboard.instantiateInitialViewController() as! AddDogViewController
        return define(init: view) {
            $0.presenter = self.createPresenter()
            return $0
        }
    }
    
    private func createPresenter() -> AddDogPresenterProtocol {
        define(init: AddDogPresenter()) {
            $0.interactor = self.createInteractor()
            return $0
        }
    }
    
    private func createInteractor() -> AddDogInteractorProtocol {
        define(init: AddDogInteractor(mediator: self.mediator))
    }
}
