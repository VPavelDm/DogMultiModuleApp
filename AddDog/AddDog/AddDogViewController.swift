//
//  AddDogViewController.swift
//  AddDog
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit

class AddDogViewController: UIViewController {
    // MARK: - Properties
    var presenter: AddDogPresenterProtocol!
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var imageURL: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func addButtonIsPressed(_ sender: Any) {
        guard let name = nameLabel.text else { return }
        guard let url = imageURL.text else { return }
        presenter.addDog(name: name, url: url)
    }
    
}
