//
//  CoinAssetsScenePresenter.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 24.01.2023.
//

import Foundation

final class CoinAssetsScenePresenter: CoinAssetsSceneViewOutput, CoinAssetsSceneInteractorOutput {
   
    
    private var dataSourse: [CoinAssetsTVCell.State] = []
    private var rawdata: [CoinAssets] = []
    private var interactor: CoinAssetsSceneInteractorInput!
    private var router: CoinAssetsSceneRouter!
    private weak var view: CoinAssetsSceneViewInput?
    
    init(interactor: CoinAssetsSceneInteractorInput,
         router: CoinAssetsSceneRouter,
         view: CoinAssetsSceneViewInput) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    // MARK: - CoinAssetsSceneViewOutput
    func numberOfRows() -> Int {
        dataSourse.count
    }
    
    func item(at indexPath: IndexPath) -> CoinAssetsTVCell.State {
        dataSourse[indexPath.row]
    }
    
    // MARK: - CoinAssetsSceneInteractorOutput
    
    func didFailLoadData(with error: String) {
        
    }
    
    func update(data: [CoinAssets]) {
        self.rawdata = data
        createDataSource(from: data)
    }
    
    private func createDataSource(from data: [CoinAssets], with filter: String? = nil) {
        var tempDataSource: [CoinAssetsTVCell.State] = []
        for item in data {
            tempDataSource.append(.init(name: item.name,
                                        symbol: item.symbol,
                                        change: item.changePercent24Hr,
                                        price: item.priceUsd))
        }
        dataSourse = tempDataSource
        
        DispatchQueue.main.async {
            self.view?.updateUI()
        }
    }
}
