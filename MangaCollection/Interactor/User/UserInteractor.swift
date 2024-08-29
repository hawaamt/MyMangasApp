//
//  UserInteractor.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import Foundation

class UserInteractor {
    
    private var networkService: NetworkService
        
    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func login(with model: UserModel) async throws -> String {
        let request = LoginUserRequest(model: model)
        let credentials = "\(model.email):\(model.password)"
        var urlRequest = request.urlRequest
        
        guard let encodedCredentials = credentials.data(using: .utf8) else {
            throw NetworkError.unauthorized
        }
        let auth = "Basic \(encodedCredentials.base64EncodedString())"
        urlRequest.addValue(auth, forHTTPHeaderField: "Authorization")
        
        let response = try await networkService.perform(from: request, with: urlRequest)
        _ = KeychainManager.shared.save(item: .token, response)
        
        return response
    }
    
    func register(with model: UserModel) async throws -> String {
        let request = RegisterUserRequest(model: model)
        let response = try await networkService.perform(from: request)
        return response
    }
    
    func logout() {
        _ = KeychainManager.shared.delete(.token)
    }
}
