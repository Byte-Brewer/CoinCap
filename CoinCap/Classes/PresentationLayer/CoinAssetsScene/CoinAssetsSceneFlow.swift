//
//  CoinAssetsSceneFlow.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 24.01.2023.
//

import Foundation
import UIKit

final class CoinAssetsSceneFlow: CoinAssetsSceneRouter {
    
    weak var containerViewController: UIViewController?
    
    init() {
        
    }
    
    // TODO: - add Dependencies injections
    func createFlow() -> UIViewController {
        guard let viewController = UIStoryboard(name: "CoinAssets", bundle: nil).instantiateInitialViewController() as? CoinAssetsSceneViewController
        else { fatalError("Couldn't find 'CoinAssets' Storyboard or create 'CoinAssetsSceneViewController'") }
        
        let networkClient: AppNetworkClient = .init()
        let assetsService: CCAssetsServiceImplementation = .init(networkClient: networkClient)
        let interactor: CoinAssetsSceneInteractor = .init(assetsService: assetsService)
        let presenter: CoinAssetsScenePresenter = .init(interactor: interactor, router: self, view: viewController)
        interactor.configure(with: presenter)
        viewController.configure(with: presenter)
        return viewController
    }
}
