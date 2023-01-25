//
//  AppNetworkClient.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 23.01.2023.
//

import Foundation
import Alamofire

protocol NetworkClient {
    func execute<T: Decodable>(request: NetworkRequest, parser: T.Type) async throws -> Result<T, Error>
}

final class AppNetworkClient: NetworkClient  {
    func execute<T: Decodable>(request: NetworkRequest, parser: T.Type) async throws  -> Result<T, Error> {
        try await withUnsafeThrowingContinuation { continuation in
            AF.request(request.url, method: .get)
                .validate()
                .responseData { response in
                    if let data = response.data {
                        do {
                            let model = try JSONDecoder().decode(parser.self, from: data)
                            continuation.resume(returning: .success(model))
                        } catch let error {
                            continuation.resume(returning: .failure(error))
                            logger.error(error)
                        }
                        return
                    }
                    if let err = response.error {
                        continuation.resume(throwing: err)
                        logger.error(err)
                        return
                    }
                    fatalError("should not get here")
                }
        }
    }
}
