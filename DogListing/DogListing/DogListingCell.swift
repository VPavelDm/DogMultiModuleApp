//
//  DogListingCell.swift
//  DogListing
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit
import DogCore

class DogListingCell: UITableViewCell {
    // MARK: - Properties
    private var cancelation: UIImageView.CancelBlock?
    // MARK: - Outlets
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogName: UILabel!
    
    // MARK: - Setup UI
    func setupContent(imageURL: String, name: String, completion: @escaping (Error) -> Void) {
        cancelation = dogImage.load(url: imageURL) { error in
            completion(error)
        }
        dogName.text = name
    }
}
