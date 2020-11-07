//
//  AbstractAPIService.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import BFAstral
import Astral
import BrightFutures

public protocol AbstractAPIService {

    func transform<T: Decodable>(request: Request) -> Future<T, NetworkingError>

}

public extension AbstractAPIService {
    var decoder: JSONDecoder { return JSONDecoder() }

    var dispatcher: BFDispatcher { return BFDispatcher() }

    func transform<T: Decodable>(request: Request) -> Future<T, NetworkingError> {
        return BFDispatcher().response(of: request)
            .map(NetworkQueue.context) { (response: Response) -> T in
                do {
                    return try self.decoder.decode(T.self, from: response.data)

                } catch let error {
                    fatalError(error.localizedDescription)

                }
            }
    }
}
