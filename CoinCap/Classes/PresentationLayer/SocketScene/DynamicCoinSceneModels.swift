//
//  DynamicCoinSceneModels.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 19.01.2023.
//

import Foundation

enum DynamicCoinScene {}

extension DynamicCoinScene {
    enum Models {}
}

// MARK: - Models View Input/Output
extension DynamicCoinScene.Models {
    
    struct ReteModel: Codable {
        let exchange, base, quote, direction: String
        let price, volume: Double
        let timestamp: Int
        let priceUsd: Double
    }
}
