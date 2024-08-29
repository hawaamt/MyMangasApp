//
//  AddMangaToMyCollection.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 29/8/24.
//

import Foundation

struct MangaParams: Codable {
    let manga: Int
    let completeCollection: Bool
    let volumesOwned: [Int]
    let readingVolume: Int?
}

struct AddMangaToMyCollectionRequest: APIRequest {

    typealias Response = String
    
    let manga: MangaParams
    
    var method: HTTPMethodType {
        .post
    }
    
    var path: String {
        return "/collection/manga"
    }
    
    var body: [String : Any] {
        manga.dictionary
    }
    
    var queryParameters: [String : Any] { [:] }
}
