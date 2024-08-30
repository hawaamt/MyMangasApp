//
//  MangaFilteredRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import Foundation

struct MangaFilteredRequest: APIRequest {

    typealias Response = MangaListDTO
    
    let filterBy: FilterByModel
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
            guard let genre = value?.genre else { return "" }
            return "/list/mangaByGenre/\(genre)"
        case .theme(let value):
            guard let theme = value?.theme else { return "" }
            return "/list/mangaByTheme/\(theme)"
        case .demographic(let value):
            guard let demographic = value?.demographic else { return "" }
            return "/list/mangaByDemographic/\(demographic)"
        case .author(let value):
            guard let author = value?.id else { return "" }
            return "/list/mangaByAuthor/\(author)"
        case .contains(let value):
            return "/search/mangasContains/\(value)"
        default:
            return "/search/manga"
        }
    }
    
    var body: [String : Any] {
        switch filterBy {
        case .custom(let customFilterModel):
            customFilterModel.dictionary
        default:
            [:]
        }
    }
    
    var queryParameters: [String : Any] {
        pagination.dictionary
    }
}
