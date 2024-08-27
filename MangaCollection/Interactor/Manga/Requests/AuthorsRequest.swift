//
//  AuthorsRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import Foundation

struct AuthorsRequest: APIRequest {

    typealias Response = [AuthorDTO]
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        "/list/authors"
    }
    
    var body: [String : Any] { [:] }
    
    var queryParameters: [String : Any] {
        [:]
    }
}
