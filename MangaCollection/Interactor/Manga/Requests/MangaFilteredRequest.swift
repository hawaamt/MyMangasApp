//
//  MangaFilteredRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import Foundation

struct MangaFilteredRequest: APIRequest {

    typealias Response = MangaListDTO
    
    let filterBy: FilterBy
    let pagination: MangaPagination
    
    var method: HTTPMethodType {
        if case .custom = filterBy {
            .post
        } else {
            .get
        }
    }
    
    var path: String {
        switch filterBy {
        case .genre(let value):
            "list/mangaByGenre/\(value)"
        case .theme(let value):
            "list/mangaByTheme/\(value)"
        case .demographic(let value):
            "list/demographics/\(value)"
        case .author(let value):
            "list/mangaByAuthor/\(value)"
        case .beginWith(let value):
            "list/mangasBeginsWith/\(value)"
        case .contains(let value):
            "list/mangasContains/\(value)"
        case .id(let value):
            "search/manga/\(value)"
        case .custom:
            "search/manga"
        }
    }
    
    var body: Codable? {
        switch filterBy {
        case .custom(let customFilterModel):
            customFilterModel
        default:
            nil
        }
    }
    
    var queryParameters: [String : Any] {
        pagination.dictionary
    }
}
