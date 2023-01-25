//
//  CCAssetsService.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 23.01.2023.
//

import Foundation

protocol CCAssetsService: AnyObject {
    func loadDate(request: NetworkRequest) async -> Result<BaseResponse<[CoinAssets]>, Error>
}

enum CCAssetsServiceError: Error {
    case networkError(String?)
}

final class CCAssetsServiceImplementation: CCAssetsService {
    
    private let networkClient: AppNetworkClient
    
    init(networkClient: AppNetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadDate(request: NetworkRequest) async -> Result<BaseResponse<[CoinAssets]>, Error> {
        do {
            let response = try await networkClient.execute(request: request, parser: BaseResponse<[CoinAssets]>.self)
            return response
        } catch let err {
            return .failure(CCAssetsServiceError.networkError(err.localizedDescription))
        }
    }
}
