//
//  NetworkService.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

enum NetworkError: Error {
    case unauthorized
    case invalidReponseFormat
    case status(Int)
}

extension Notification.Name {
    static let logout = Notification.Name("logout")
}

class NetworkService {
    
    static var shared = NetworkService()
    
    private var isRenewingToken: Bool = false
        
    func perform<Request: APIRequest>(from apiRequest: Request,
                                      with request: URLRequest? = nil) async throws -> Request.Response {
        
        var urlRequest: URLRequest
        if let request {
            urlRequest = request
        } else {
            urlRequest = apiRequest.urlRequest
        }

        print("URL: \(urlRequest.url?.absoluteString ?? "")")
        print(String(data: urlRequest.httpBody ?? Data(), encoding: .utf8) ?? "")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidReponseFormat
        }
        
        if KeychainManager.shared.isUserLogged {
            if response.statusCode == 401 && !isRenewingToken {
                isRenewingToken = false
                NotificationCenter.default.post(name: .logout, object: nil)
                throw NetworkError.unauthorized
            } else {
                return try manageResponse(data: data, response: response, responseType: Request.Response.self)
            }
        } else {
            return try manageResponse(data: data, response: response, responseType: Request.Response.self)
        }
    }
    
    private func manageResponse<ResponseType: Codable>(data: Data,
                                                       response: URLResponse,
                                                       responseType: ResponseType.Type) throws -> ResponseType {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidReponseFormat
        }
        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.status(response.statusCode)
        }
        
        if ResponseType.self == String.self {
            guard let result = String(data: data, encoding: .utf8) as? ResponseType else {
                throw NetworkError.invalidReponseFormat
            }
            return result
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(ResponseType.self, from: data)
    }
    
    func renewToken() async throws -> String {
        var request = UserRenewTokenRequest().urlRequest
        if let token = KeychainManager.shared.read(.token) {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        let (data, response) = try await URLSession.shared.data(for: request)
       
        guard let response = response as? HTTPURLResponse,
              let result = String(data: data, encoding: .utf8) else {
            throw NetworkError.invalidReponseFormat
        }
        
        if response.statusCode == 401 {
            isRenewingToken = false
            NotificationCenter.default.post(name: .logout, object: nil)
            throw NetworkError.unauthorized
        }

        return result
    }
}
