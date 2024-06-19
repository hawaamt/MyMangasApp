//
//  Manga+Data.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

extension Manga {
    
    var autors: String {
        self.authors.map {
            "\(($0.firstName ?? "")) \($0.lastName ?? "")".trailingSpacesTrimmed
        }.joined(separator: " | ")
    }
    
    var scoreInfo: String {
        guard let score = self.score else {
            return "- / 10"
        }
        return "\(score) / 10"
    }
    
    var volumesInfo: String {
        guard let volumes = self.volumes else {
            return "-"
        }
        return "\(volumes) chapters"
    }
    
    var year: String {
        guard let startDate = self.startDate else { return "-" }
        return startDate.year
    }
}
