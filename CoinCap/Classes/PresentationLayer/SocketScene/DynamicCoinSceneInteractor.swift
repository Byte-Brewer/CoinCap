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
    private let state: PassthroughSubject<SocketState,Never>
    private var subscriptions: Set<AnyCancellable> = .init()
    private weak var presenter: DynamicCoinSceneInteractorOutput?
    
    init(socketService: CCSocketService,
         state: PassthroughSubject<SocketState, Never>) {
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
            case let .info(text):
                do {
                    let state = try JSONDecoder().decode(DynamicCoinScene.Models.ReteModel.self, from: Data(text.utf8))
                    self.presenter?.update(state: state)
                } catch let error {
                    logger.error("Could not parse JSON: \(text) with error: \(error)")
                    self.presenter?.didFailLoadData(with: error.localizedDescription)
                }
                
            case let .error(text):
                self.presenter?.didFailLoadData(with: text ?? "")
                
            case .isConnected(let isConnect):
                logger.info("isConnected: \(isConnect)")
            }
        }.store(in: &subscriptions)
    }
}
