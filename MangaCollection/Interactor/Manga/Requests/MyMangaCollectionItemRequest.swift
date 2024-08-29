//
//  MyMangaCollectionItemRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 29/8/24.
//

import Foundation

struct MyMangaCollectionItemRequest: APIRequest {

    typealias Response = MangaMyCollectionDTO
    
    let mangaId: Int
        
    var method: HTTPMethodType {
        .get
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
