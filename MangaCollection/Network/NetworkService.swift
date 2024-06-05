//
//  NetworkService.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

enum NetworkError: Error {
    case invalidReponseFormat
    case status(Int)
}

struct NetworkService {
    
    static var shared = NetworkService()
    
    func perform<Request: APIRequest>(from request: Request) async throws -> Request.Response {
        print("URL: \(request.urlRequest.url?.absoluteString ?? "")")
        print("Request:")
        print(String(data: request.urlRequest.httpBody ?? Data(), encoding: .utf8) ?? "")
        
        let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
        let decoder = JSONDecoder()
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidReponseFormat
        }
        
        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.status(response.statusCode)
        }
        
        return try decoder.decode(Request.Response.self, from: data)
    }
}
