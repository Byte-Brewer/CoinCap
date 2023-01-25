//
//  NetworkRequest.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 23.01.2023.
//

import Foundation

protocol NetworkRequest {
    var url: URL { get }
}

struct CoinAssetsRequest: NetworkRequest {
    let url: URL = .init(string: "https://api.coincap.io/v2/assets")!
}
