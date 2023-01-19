//
//  CCSocketService.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 19.01.2023.
//

import Foundation
import Starscream
import Combine

protocol CCSocketService: AnyObject {
    func startUpdate()
    func stopUpdate()
}

enum SocketState {
    case isConnected(Bool)
    case error(String?)
    case info(String)
}

final class CCSocketServiceImplementation: CCSocketService, WebSocketDelegate {
    
    private let state: PassthroughSubject<SocketState,Never>
    private let socket: WebSocket
    
    init(request: URLRequest, state: PassthroughSubject<SocketState,Never>) {
        self.state = state
        self.socket = WebSocket(request: request)
        socket.delegate = self
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        print("websocketDidReceiveMessage: ", event)
        switch event {
        case .connected(let headers):
            state.send(.isConnected(true))
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            let text = "websocket is disconnected: \(reason) with code: \(code)"
            state.send(.isConnected(false))
            state.send(.error(text))
            print(text)
        case .text(let string):
            let text = "Received text: \(string)"
            state.send(.info(string))
            print(text)
        case .binary(let data):
            print("Received data: \(data.count)")
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
            state.send(.isConnected(false))
            state.send(.error(error?.localizedDescription))
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
