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
    
    func createFlow() -> UIViewController {
        CoinAssetsSceneAssemblyImplementation().createModule(with: .init(router: self))
    }
}
