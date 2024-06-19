//
//  ThemesRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import Foundation

struct ThemesRequest: APIRequest {

    typealias Response = [String]
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        "/list/themes"
    }
    
    var body: Codable? = nil
    
    var queryParameters: [String : Any] {
        [:]
    }
}
