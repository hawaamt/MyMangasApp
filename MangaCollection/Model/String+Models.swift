//
//  String+Models.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import Foundation

extension String {
    
    static var empty = "-"
    
    var demographic: Demographic {
        Demographic(id: UUID().uuidString,
                    demographic: self)
    }
    
    var genre: Genre {
        Genre(id: UUID().uuidString,
              genre: self)
    }
    
    var theme: Theme {
        Theme(id: UUID().uuidString,
              theme: self)
    }
}
