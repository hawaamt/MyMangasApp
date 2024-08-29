//
//  DeleteMyMangaCollectionRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 29/8/24.
//

import Foundation

struct DeleteMyMangaCollectionRequest: APIRequest {
    typealias Response = String
        
    let mangaId: Int
    
    var method: HTTPMethodType {
        .delete
    }
    
    var path: String {
        return "/collection/manga/\(mangaId)"
    }
    
    var body: [String : Any] {
        [:]
    }
    
    var queryParameters: [String : Any] {
        [:]
    }
}
