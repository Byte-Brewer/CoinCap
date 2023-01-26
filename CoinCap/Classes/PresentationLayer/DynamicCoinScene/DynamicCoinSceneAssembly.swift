//
//  DynamicCoinSceneAssembly.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 22.01.2023.
//

import Foundation
import UIKit
import Combine

protocol DynamicCoinSceneAssembly: AnyObject {
    
    func createModule(with dependency: DynamicCoinSceneDependency) -> UIViewController
}

struct DynamicCoinSceneDependency {
    let router: DynamicCoinSceneRouter
}

/// Entry point to DynamicCoinScene
final class DynamicCoinSceneAssemblyImplementation: DynamicCoinSceneAssembly {
    
    // TODO: - add Dependencies injections
    func createModule(with dependency: DynamicCoinSceneDependency) -> UIViewController {
        guard let viewController = UIStoryboard(name: "DynamicCoin", bundle: nil)
            .instantiateInitialViewController() as? DynamicCoinSceneViewController
        else { fatalError("Couldn't find 'DynamicCoin' Storyboard or create 'DynamicCoinSceneViewController'") }
        
        let request: URLRequest = .init(url: URL(string: "wss://ws.coincap.io/trades/binance")!)
        let state: PassthroughSubject<SocketState<DynamicCoinScene.Models.ReteModel>, Never> = .init()
        let socketService: CCSocketServiceImplementation = .init(request: request, state: state)
        let interactor: DynamicCoinSceneInteractor = .init(socketService: socketService, state: state)
        let presenter: DynamicCoinScenePresenter = .init(
            interactor: interactor,
            router: dependency.router,
            view: viewController
        )
        interactor.configure(with: presenter)
        viewController.configure(with: presenter)
        return viewController
    }
}
