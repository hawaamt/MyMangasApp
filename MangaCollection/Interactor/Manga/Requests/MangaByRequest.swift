//
//  MangaByRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

struct MangaByRequest: APIRequest {

    typealias Response = MangaListDTO
    
    let mangaBy: MangaBy
    let pagination: MangaPagination
    
    var method: HTTPMethodType {
        .get
    }
    
    var path: String {
        switch mangaBy {
        case .genre(let genre): 
            return "list/mangaByGenre/\(genre.genre)"
        case .theme(let theme):
            return "list/mangaByTheme/\(theme.theme)"
        case .demographic(let demographic):
            return "list/mangaByDemographic/\(demographic.demographic)"
        case .author(let author):
            return "list/mangaByAuthor/\(author.id)"
        }
    }
    
    var body: [String : Any] { [:] }

    var queryParameters: [String : Any] {
        pagination.dictionary
    }
}
