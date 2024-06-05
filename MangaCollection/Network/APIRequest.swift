//
//  APIRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol APIRequest {
    associatedtype Response: Codable

    var method: HTTPMethodType { get }
    var path: String { get }
    var queryParameters: [String: Any] { get }
    var body: Codable? { get }
}

extension APIRequest {
    
    private var baseUrl: URL {
        URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!
    }
    
    var urlRequest: URLRequest {
        let fullURL = baseUrl.appending(path: self.path)
                
        var request: URLRequest
        
        switch method {
            case .get:
                request = get(url: fullURL)
            case .post:
                request = post(url: fullURL)
            default:
                request = URLRequest(url: fullURL)
        }
        
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    private func get(url: URL) -> URLRequest {
        guard var components = URLComponents(url: url,
                                          resolvingAgainstBaseURL: false) else {
            return URLRequest(url: url)
        }
        
        components.queryItems = queryParameters.map { URLQueryItem(name: $0, value: "\($1)") }
        
        guard let finalUrl = components.url else {
            return URLRequest(url: url)
        }
        
        return URLRequest(url: finalUrl)
    }
    
    private func post(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        
        if let body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        return request
    }
}
