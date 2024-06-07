//
//  MangaBestRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import Foundation

struct MangaBestRequest: APIRequest {

    typealias Response = MangaListDTO
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        "/list/bestMangas"
    }
    
    var body: Codable? = nil
    
    var queryParameters: [String : Any] {
        [:]
    }
}
