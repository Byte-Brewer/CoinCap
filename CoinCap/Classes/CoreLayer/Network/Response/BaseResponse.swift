//
//  BaseResponse.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 23.01.2023.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let data: T
}

struct CoinAssets: Codable {
    let id, rank, symbol, name: String
    let supply, marketCapUsd, volumeUsd24Hr: String
    let priceUsd, changePercent24Hr: String
    let vwap24Hr, maxSupply: String?
}
