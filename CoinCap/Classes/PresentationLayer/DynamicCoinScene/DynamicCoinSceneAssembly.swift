//
//  DynamicCoinSceneAssembly.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 22.01.2023.
//

import Foundation

protocol DynamicCoinSceneAssembly: AnyObject {
    
    func createModule(with dependency: DynamicCoinSceneDependency)
}

struct DynamicCoinSceneDependency {
    let socketService: CCSocketService
}

final class DynamicCoinSceneAssemblyImplementation: DynamicCoinSceneAssembly {
    
    func createModule(with dependency: DynamicCoinSceneDependency) {
        
    }
}
