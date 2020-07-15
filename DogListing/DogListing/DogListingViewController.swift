//
//  DogListingViewController.swift
//  DogListing
//
//  Created by Pavel Vaitsikhouski on 7/15/20.
//  Copyright © 2020 vpaveldm. All rights reserved.
//

import UIKit
import RxSwift

class DogListingViewController: UIViewController {
    // MARK: - Properties
    var presenter: DogListingPresenterProtocol!
    private let disposeBag = DisposeBag()
    private var viewModels: [DogListingViewModel] = []
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideContent()
        setupBindings()
        presenter.loadDogs()
    }
    
    // MARK: - setup UI
    private func setupBindings() {
        presenter.dogViewModelsObservable
            .subscribe(onNext: { [weak self] viewModels in
                self?.viewModels = viewModels
                self?.showContent()
            })
            .disposed(by: disposeBag)
    }
    
    private func showContent() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.tableView.alpha = 1
        }
    }
    
    private func hideContent() {
        activityIndicator.startAnimating()
        tableView.alpha = 0
    }
    
    private func showError(error: Error) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Понятно", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DogListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogListingCell") as! DogListingCell
        let viewModel = viewModels[indexPath.row]
        cell.setupContent(imageURL: viewModel.imageURL, name: viewModel.name) { [weak self] error in
            self?.showError(error: error)
        }
        return cell
    }
}
