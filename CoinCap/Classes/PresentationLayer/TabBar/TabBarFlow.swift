//
//  TabBarFlow.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 19.01.2023.
//

import Foundation
import UIKit

final class TabBarFlow {
    
    
    func createFlow() -> UIViewController {
        let tabBar: MainTabBar = .init()
        
        return tabBar
    }
    
}


final class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .yellow
        tabBar.tintColor = .label
        setupVCs()
    }
    
    private func setupVCs() {
        let dflow = DynamicCoinSceneFlow()
        let dvc = UINavigationController(rootViewController: dflow.createFlow())
        dvc.tabBarItem.title = "dynamic"
        dvc.tabBarItem.image = .strokedCheckmark
        let aflow = CoinAssetsSceneFlow()
        let avc = UINavigationController(rootViewController: aflow.createFlow())
        avc.tabBarItem.title = "assets"
        avc.tabBarItem.image = .strokedCheckmark
        viewControllers = [
            avc, dvc
        ]
    }
}
