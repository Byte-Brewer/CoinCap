//
//  CoinAssetsSceneViewController.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 24.01.2023.
//

import UIKit

protocol CoinAssetsSceneViewInput: BaseViewInput {
    func updateUI()
}

protocol CoinAssetsSceneViewOutput: AnyObject {
    func numberOfRows() -> Int
    func item(at indexPath: IndexPath) -> CoinAssetsTVCell.State
}

final class CoinAssetsSceneViewController: UIViewController, CoinAssetsSceneViewInput {
   
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var spinnerView: UIView!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: - Propetry
    private var presenter: CoinAssetsSceneViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "assets"
        view.backgroundColor = .systemIndigo
        setupTableView()
        spinner.style = .large
        spinnerView.isHidden = false
        spinner.startAnimating()
    }
    
    func configure(with presenter: CoinAssetsSceneViewOutput) {
        self.presenter = presenter
    }
    
    // MARK: - CoinAssetsSceneViewInput
    func updateUI() {
        self.tableView.reloadData()
        spinnerView.isHidden = true
        spinner.stopAnimating()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CoinAssetsTVCell", bundle: nil),
                                forCellReuseIdentifier: CoinAssetsTVCell.reuseIdentifier)
    }
}

extension CoinAssetsSceneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinAssetsTVCell.reuseIdentifier,
                                                       for: indexPath) as? CoinAssetsTVCell
        else { fatalError("Could not cast cell to 'CoinAssetsTVCell'") }
        
        cell.configure(state: presenter.item(at: indexPath))
        return cell
    }
}
