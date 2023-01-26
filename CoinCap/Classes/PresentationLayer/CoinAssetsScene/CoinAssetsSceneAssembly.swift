//
//  CoinAssetsSceneAssembly.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 24.01.2023.
//

import Foundation
import UIKit

protocol CoinAssetsSceneAssembly: AnyObject {
    func createModule(with dependency: CoinAssetsSceneDependency) -> UIViewController
}

/// CoinAssetsScene dependencies
struct CoinAssetsSceneDependency {
    let router: CoinAssetsSceneRouter
}

/// Entry point to CoinAssetsScene
final class CoinAssetsSceneAssemblyImplementation: CoinAssetsSceneAssembly {
    
    // TODO: - add Dependencies injections
    func createModule(with dependency: CoinAssetsSceneDependency) -> UIViewController {
        guard let viewController = UIStoryboard(name: "CoinAssets", bundle: nil)
            .instantiateInitialViewController() as? CoinAssetsSceneViewController
        else { fatalError("Couldn't find 'CoinAssets' Storyboard or create 'CoinAssetsSceneViewController'") }
        
        let networkClient: AppNetworkClient = .init()
        let assetsService: CCAssetsServiceImplementation = .init(networkClient: networkClient)
        let interactor: CoinAssetsSceneInteractor = .init(assetsService: assetsService)
        let presenter: CoinAssetsScenePresenter = .init(
            interactor: interactor,
            router: dependency.router,
            view: viewController
        )
        interactor.configure(with: presenter)
        viewController.configure(with: presenter)
        return viewController
    }
}
