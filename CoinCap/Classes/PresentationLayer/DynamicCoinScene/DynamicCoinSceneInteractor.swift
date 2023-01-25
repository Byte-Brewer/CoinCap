//
//  DynamicCoinSceneInteractor.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 19.01.2023.
//

import Foundation
import Combine

protocol DynamicCoinSceneInteractorOutput: AnyObject {
    func didFailLoadData(with error: String)
    func update(state: DynamicCoinScene.Models.ReteModel)
}

protocol DynamicCoinSceneInteractorInput: AnyObject {
    func startUpdate()
    func stopUpdate()
}

final class DynamicCoinSceneInteractor: DynamicCoinSceneInteractorInput {
    
    private let socketService: CCSocketService
    private let state: PassthroughSubject<SocketState<DynamicCoinScene.Models.ReteModel>,Never>
    private var subscriptions: Set<AnyCancellable> = .init()
    private weak var presenter: DynamicCoinSceneInteractorOutput?
    
    init(socketService: CCSocketService,
         state: PassthroughSubject<SocketState<DynamicCoinScene.Models.ReteModel>, Never>) {
        self.socketService = socketService
        self.state = state
        bind()
    }
    
    func configure(with presenter: DynamicCoinSceneInteractorOutput) {
        self.presenter = presenter
    }
   
    // MARK: - DynamicCoinSceneInteractorInput
    func startUpdate() {
        socketService.startUpdate()
    }
    
    func stopUpdate() {
        socketService.stopUpdate()
    }
    
    // MARK: - class func
    private func bind() {
        state.sink { [weak self] socketState in
            guard let self else { return }
            
            switch socketState {
            case let .info(model):
                self.presenter?.update(state: model)
                
            case .error(let error):
                self.presenter?.didFailLoadData(with: error.localizedDescription)
                
            case .isConnected(let isConnect):
                logger.info("isConnected: \(isConnect)")
            }
        }.store(in: &subscriptions)
    }
}
