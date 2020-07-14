//
//  DogProfileDI.swift
//  DogProfile
//
//  Created by Pavel Vaitsikhouski on 7/14/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import EasyDi

class DogProfileDI: Assembly {
    var view: DogProfileViewController {
        define(init: DogProfileViewController())
    }
}
