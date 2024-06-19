//
//  Genres+Mocks.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import Foundation

extension Genre {
    
    static var genre1 = Genre(id: UUID().uuidString,
                             genre: "Action")
    
    static var genre2 = Genre(id: UUID().uuidString,
                             genre: "Horror")
    
    static var genre3 = Genre(id: UUID().uuidString,
                             genre: "Supernatural")
    
    static var genre4 = Genre(id: UUID().uuidString,
                             genre: "Ecchi")
    
    static var genre5 = Genre(id: UUID().uuidString,
                             genre: "Erotica")
    
    static var mockList: [Genre] = [.genre1, .genre2, .genre3, .genre4, .genre5]
}
