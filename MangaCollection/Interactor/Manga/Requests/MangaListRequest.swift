//
//  MangaListRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

struct MangaListRequest: APIRequest {

    typealias Response = MangaListDTO
    
    let pagination: MangaPagination
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        "/list/mangas"
    }
    
    var body: [String : Any] { [:] }
    
    var queryParameters: [String : Any] {
        pagination.dictionary
    }
}
