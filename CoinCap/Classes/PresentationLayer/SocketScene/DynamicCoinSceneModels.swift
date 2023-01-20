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
        enum Direction: String, Codable {
            case buy, sell
        }
        
        let exchange, base, quote: String
        let direction: Direction
        let price, volume: Double
        let timestamp: Int
        let priceUsd: Double
    }
}
