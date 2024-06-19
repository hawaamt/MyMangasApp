//
//  String+date.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 13/6/24.
//

import Foundation

extension String {
    
    var date: Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: self)
    }
}
