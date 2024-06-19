//
//  GenresRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import Foundation

struct GenresRequest: APIRequest {

    typealias Response = [String]
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        "/list/genres"
    }
    
    var body: Codable? = nil
    
    var queryParameters: [String : Any] {
        [:]
    }
}
