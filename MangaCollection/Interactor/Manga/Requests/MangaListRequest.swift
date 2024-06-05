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
    
    init(pagination: MangaPagination) {
        self.pagination = pagination
    }
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        "/list/mangas"
    }
    
    var body: Codable? = nil
    
    var queryParameters: [String : Any] {
        pagination.dictionary
    }
}
