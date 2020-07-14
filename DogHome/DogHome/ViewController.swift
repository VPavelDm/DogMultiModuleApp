//
//  ViewController.swift
//  DogHome
//
//  Created by Pavel Vaitsikhouski on 7/14/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit
import DogProtocols
import DogProfile

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickMeIsPressed(_ sender: Any) {
        let view = DogProfileDI.instance().getDogProfile(id: "123")
        navigationController?.pushViewController(view, animated: true)
    }
    
}

