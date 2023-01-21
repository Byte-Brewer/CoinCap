//
//  DynamicCoinScenePresenter.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 19.01.2023.
//

import Foundation

final class DynamicCoinScenePresenter: DynamicCoinSceneViewOutput, DynamicCoinSceneInteractorOutput {
   
    // MARK: - Propetries
    private var filterValue: DynamicCoinScene.Models.ReteModel.Direction = .buy
    private var interactor: DynamicCoinSceneInteractorInput!
    private var router: DynamicCoinSceneRouter!
    private weak var view: DynamicCoinSceneViewInput?
    
    init(interactor: DynamicCoinSceneInteractorInput!,
         router: DynamicCoinSceneRouter!,
         view: DynamicCoinSceneViewInput?) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    // MARK: - DynamicCoinSceneInteractorOutput
    func didFailLoadData(with error: String) {
        view?.showError(message: error)
    }
    
    func update(state: DynamicCoinScene.Models.ReteModel) {
        if state.direction == filterValue {
            view?.update(state: state)
        }
    }
    
    // MARK: - DynamicCoinSceneViewOutput
    func didTapStart() {
        interactor.startUpdate()
    }
    
    func didTapStop() {
        interactor.stopUpdate()
    }
    
    func viewDidAppear() {
        interactor.startUpdate()
    }
    
    func viewWillDisappeare() {
        interactor.stopUpdate()
    }
    
    func didTapSwitch(on index: Int) {
        filterValue = index == 0 ? .buy : .sell
    }
}
