//
//  DynamicCoinSceneFlow.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 19.01.2023.
//

import Foundation
import UIKit
import Combine


final class DynamicCoinSceneFlow: DynamicCoinSceneRouter {
    
    weak var containerViewController: UIViewController?
    
    init() {

    }
    
    // TODO: - add Dependencies injections
    func createFlow() -> UIViewController {
        guard let viewController = UIStoryboard(name: "DynamicCoin", bundle: nil).instantiateInitialViewController() as? DynamicCoinSceneViewController
        else { fatalError("can't find 'DynamicCoin' Storyboard or create DynamicCoinSceneViewController") }
    
        let request: URLRequest = .init(url: URL(string: "wss://ws.coincap.io/trades/binance")!)
        let state: PassthroughSubject<SocketState, Never> = .init()
        let socketService: CCSocketServiceImplementation = .init(request: request, state: state)
        let interactor: DynamicCoinSceneInteractor = .init(socketService: socketService, state: state)
        let presenter: DynamicCoinScenePresenter = .init(interactor: interactor, router: self, view: viewController)
        interactor.configure(with: presenter)
        viewController.configure(with: presenter)
        return viewController
    }
}
