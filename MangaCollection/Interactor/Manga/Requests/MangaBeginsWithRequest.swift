//
//  MangaBeginsWithRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 25/8/24.
//

import Foundation

struct MangaBeginsWithRequest: APIRequest {

    typealias Response = [MangaItemDTO]
    
    let filter: String
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        return "search/mangasBeginsWith/\(filter)"
    }
    
    var body: [String : Any] { [:] }
    
    var queryParameters: [String : Any] { [:] }
}
