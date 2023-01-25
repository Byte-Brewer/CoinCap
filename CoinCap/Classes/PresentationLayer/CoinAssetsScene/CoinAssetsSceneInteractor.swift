//
//  CoinAssetsSceneInteractor.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 24.01.2023.
//

import Foundation


protocol CoinAssetsSceneInteractorOutput: AnyObject {
    func didFailLoadData(with error: String)
    func update(data: [CoinAssets])
}

protocol CoinAssetsSceneInteractorInput: AnyObject {
    func getDate()
}

final class CoinAssetsSceneInteractor: CoinAssetsSceneInteractorInput {
    
    private weak var presenter: CoinAssetsSceneInteractorOutput?
    private let assetsService: CCAssetsService
    
    init(assetsService: CCAssetsService) {
        self.assetsService = assetsService
    }
    
    func configure(with presenter: CoinAssetsSceneInteractorOutput) {
        self.presenter = presenter
        getDate()
    }
    
    func getDate() {
        Task {
            let request: CoinAssetsRequest = .init()
            let result = await assetsService.loadDate(request: request)
            switch result {
            case .success(let success):
                presenter?.update(data: success.data)
            case .failure(let failure):
                presenter?.didFailLoadData(with: failure.localizedDescription)
            }
        }
    }
}
