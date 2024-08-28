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

protocol NetworkServiceDelegate: AnyObject {
    func exitUser()
}

struct NetworkService {
    
    static var shared = NetworkService()
    
    weak var delegate: NetworkServiceDelegate?
    
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
        
        if response.statusCode == 401 {
            do {
                let token = try await renewToken()
                _ = KeychainManager.shared.save(item: .token, token)
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                return try manageResponse(data: data, response: response, responseType: Request.Response.self)
            } catch {
                throw NetworkError.unauthorized
                delegate?.exitUser()
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
        let request = UserRenewTokenRequest()
        let response = try await perform(from: request)
        return response
    }
}
