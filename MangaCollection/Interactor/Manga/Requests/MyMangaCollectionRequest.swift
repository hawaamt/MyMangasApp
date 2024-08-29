//
//  MyMangaCollectionRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 29/8/24.
//

import Foundation

struct MyMangaCollectionRequest: APIRequest {

    typealias Response = [MangaMyCollectionDTO]
        
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        return "/collection/manga"
    }
    
    var body: [String : Any] {
        [:]
    }
    
    var queryParameters: [String : Any] {
        [:]
    }
}
