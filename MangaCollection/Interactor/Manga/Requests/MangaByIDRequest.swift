//
//  MangaByIDRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 25/8/24.
//

import Foundation

struct MangaByIDRequest: APIRequest {

    typealias Response = MangaItemDTO?
    
    let mangaId: String
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        return "/search/manga/\(mangaId)"
    }
    
    var body: [String : Any] { [:] }
    
    var queryParameters: [String : Any] {
        [:]
    }
}
