//
//  DogGlobalMediator.swift
//  DogHome
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import Foundation
import DogProtocols
import DogProfile
import DogListing

class DogGlobalMediator: DogGlobalMediatorProtocol {
    func getDogProfileProtocol() -> DogProfileProtocol {
        let assembly = DogProfileDI.instance()
        assembly.mediator = self
        return assembly
    }
    
    func getDogListingProtocol() -> DogListingProtocol {
        let assembly = DogListingDI.instance()
        assembly.mediator = self
        return assembly
    }
}
