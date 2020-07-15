//
//  DogNetworkDI.swift
//  DogNetwork
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import EasyDi
import DogProtocols

public class DogNetworkDI: Assembly {
    public var manager: DogNetworkManagerProtocol {
        define(init: DogNetworkManager())
    }
}
