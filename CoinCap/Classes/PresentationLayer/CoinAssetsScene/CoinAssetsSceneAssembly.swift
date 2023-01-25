//
//  CoinAssetsSceneAssembly.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 24.01.2023.
//

import Foundation

protocol CoinAssetsSceneAssembly: AnyObject {
    
    func createModule(with dependency: CoinAssetsSceneDependency)
}

struct CoinAssetsSceneDependency {
    
}

final class CoinAssetsSceneAssemblyImplementation: CoinAssetsSceneAssembly {
    
    func createModule(with dependency: CoinAssetsSceneDependency) {
        
    }
}
