//
//  ViewController.swift
//  AddDogSample
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit
import AddDog
import DogProtocols

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickMeIsPressed(_ sender: Any) {
        let assembly = AddDogDI.instance()
        assembly.mediator = Mediator()
        let view = assembly.createView()
        navigationController?.pushViewController(view, animated: true)
    }
    
    class Mediator: DogGlobalMediatorProtocol {
        func getDogProfileProtocol() -> DogProfileProtocol {
            fatalError()
        }
        
        func getDogListingProtocol() -> DogListingProtocol {
            fatalError()
        }
        
        func getDogNetwork() -> DogNetworkManagerProtocol {
            DogNetwork()
        }
    }
    
    class DogNetwork: DogNetworkManagerProtocol {
        func loadDogs(completion: @escaping (Result<JSON, Error>) -> Void) {
        }
        
        func loadDog(id: String, completion: @escaping (Result<JSON, Error>) -> Void) {
        }
        
        func uploadDog(name: String, url: String, completion: @escaping (Result<String, Error>) -> Void) {
            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + .seconds(1)) {
                completion(.success("1"))
            }
        }
    }
    
}

