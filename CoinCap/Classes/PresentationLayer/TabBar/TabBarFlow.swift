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
        let dynamicFlow = DynamicCoinSceneFlow()
        let dynamicViewController = UINavigationController(rootViewController: dynamicFlow.createFlow())
        dynamicViewController.tabBarItem.title = "dynamic"
        dynamicViewController.tabBarItem.image = .strokedCheckmark
        let coinFlow = CoinAssetsSceneFlow()
        let coinViewController = UINavigationController(rootViewController: coinFlow.createFlow())
        coinViewController.tabBarItem.title = "assets"
        coinViewController.tabBarItem.image = .strokedCheckmark
        viewControllers = [coinViewController, dynamicViewController]
    }
}
