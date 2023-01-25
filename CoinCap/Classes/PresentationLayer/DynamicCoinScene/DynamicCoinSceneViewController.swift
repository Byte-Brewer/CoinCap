//
//  DynamicCoinSceneViewController.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 18.01.2023.
//

import UIKit

protocol DynamicCoinSceneViewInput: AnyObject {
    func showError(message: String)
    func update(state: DynamicCoinScene.Models.ReteModel)
}

protocol DynamicCoinSceneViewOutput: AnyObject {
    func didTapStart()
    func didTapStop()
    func viewDidAppear()
    func viewWillDisappeare()
    func didTapSwitch(on index: Int)
}

final class DynamicCoinSceneViewController: UIViewController, DynamicCoinSceneViewInput {
    
    // MARK: - @IBOutlet
    @IBOutlet private var labels: [UILabel]!
    
    // MARK: - Propetry
    private var presenter: DynamicCoinSceneViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.title = "dynamic"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappeare()
    }
    
    func configure(with presenter: DynamicCoinSceneViewOutput) {
        self.presenter = presenter
    }
    
    // MARK: - DynamicCoinSceneViewInput
    func showError(message: String) {
        let vc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default))
        self.present(vc, animated: true)
    }
    
    func update(state: DynamicCoinScene.Models.ReteModel) {
        labels[0].text = state.exchange
        labels[1].text = state.base
        labels[2].text = state.quote
        labels[3].text = state.direction.rawValue
        labels[4].text = String(state.price)
        labels[5].text = String(state.volume)
        labels[6].text = String(state.timestamp)
        labels[7].text = String(state.priceUsd)
    }
    
    // MARK: - Actions
    @IBAction private func start() {
        presenter.didTapStart()
    }
    
    @IBAction private func stop() {
        presenter.didTapStop()
    }
    
    @IBAction private func switchAction(_ sender: UISegmentedControl) {
        presenter.didTapSwitch(on: sender.selectedSegmentIndex)
    }
}
