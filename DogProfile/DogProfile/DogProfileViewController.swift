//
//  DogProfileViewController.swift
//  DogProfile
//
//  Created by Pavel Vaitsikhouski on 7/14/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit
import RxSwift
import DogCore

class DogProfileViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Properties
    private var imageLoadingCancelation: UIImageView.CancelBlock?
    private let disposeBag = DisposeBag()
    var presenter: DogProfilePresenterProtocol!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadDogProfile()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageLoadingCancelation?()
    }
    
    // MARK: - Setup Bindings
    private func setupBindings() {
        presenter.dogProfileObservable
            .subscribe(onNext: { [weak self] viewModel in
                self?.nameLabel.text = viewModel.name
                self?.loadImage(url: viewModel.imageURL)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI
    private func loadImage(url: String) {
        imageLoadingCancelation = dogImage.load(url: url) { [weak self] error in
            self?.showError(error, url: url)
        }
    }
    
    private func showError(_ error: Error, url: String) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Понятно", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        let again = UIAlertAction(title: "Попробовать еще раз", style: .default) { [weak self] _ in
            self?.loadImage(url: url)
        }
        alert.addAction(again)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
