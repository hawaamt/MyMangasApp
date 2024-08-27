//
//  SearchAuthorRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 23/8/24.
//

import Foundation

struct SearchAuthorRequest: APIRequest {

    typealias Response = [AuthorDTO]
    
    let author: String
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        "/search/author/\(author)"
    }
    
    var body: [String : Any] { [:] }
    
    var queryParameters: [String : Any] { [:] }
}
