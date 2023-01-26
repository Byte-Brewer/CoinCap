//
//  DynamicCoinSceneFlow.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 19.01.2023.
//

import Foundation
import UIKit

final class DynamicCoinSceneFlow: DynamicCoinSceneRouter {
    
    weak var containerViewController: UIViewController?
    
    init() {

    }
    
    func createFlow() -> UIViewController {
        DynamicCoinSceneAssemblyImplementation().createModule(with: .init(router: self))
    }
}
