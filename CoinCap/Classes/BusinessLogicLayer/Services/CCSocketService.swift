//
//  CCSocketService.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 19.01.2023.
//

import Foundation
import Starscream
import Combine
import OSLog

protocol CCSocketService: AnyObject {
    func startUpdate()
    func stopUpdate()
}

enum SocketServiceError: Error {
    case sockerError(Error?)
    case socketDisconected
    case sockerModelParseError
}

enum SocketState<T:Codable> {
    case isConnected(Bool)
    case error(SocketServiceError)
    case info(T)
}

final class CCSocketServiceImplementation<T: Codable>: CCSocketService, WebSocketDelegate {
    
    private let state: PassthroughSubject<SocketState<T>, Never>
    private let socket: WebSocket
    
    init(request: URLRequest, state: PassthroughSubject<SocketState<T>,Never>) {
        self.state = state
        self.socket = WebSocket(request: request)
        socket.delegate = self
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
        case .connected(let headers):
            state.send(.isConnected(true))
            logger.info("info websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            let text = "websocket is disconnected: \(reason) with code: \(code)"
            state.send(.isConnected(false))
            state.send(.error(.socketDisconected))
            logger.warning("\(text)")
        case .text(let string):
            logger.info("Received text: \(string)")
            do {
                let model = try JSONDecoder().decode(T.self, from: Data(string.utf8))
                state.send(.info(model))
            } catch let error {
                logger.error("Could not parse JSON: \(string) with error: \(error)")
                state.send(.error(.sockerModelParseError))
            }
        case .binary(let data):
            logger.info("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            state.send(.isConnected(false))
        case .error(let error):
            logger.error("Unexpected error: \(String(describing: error))")
            state.send(.isConnected(false))
            state.send(.error(.sockerError(error)))
        }
    }
    
    // MARK: - CCSocketService
    func startUpdate() {
        socket.connect()
    }
    
    func stopUpdate() {
        socket.disconnect()
    }
}
