//
//  CollectionItem.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 3/7/24.
//

import Foundation
import SwiftData

@Model
class CollectionItem: Identifiable {
    @Attribute(.unique) let id: String
    let manga: Manga
    var readingVolume: Int?
    var volumesOwned: [Int]
    var completeCollection: Bool
    
    init(id: String, 
         manga: Manga,
         readingVolume: Int? = nil,
         volumesOwned: [Int] = [],
         completeCollection: Bool = false) {
        self.id = id
        self.manga = manga
        self.readingVolume = readingVolume
        self.volumesOwned = volumesOwned
        self.completeCollection = completeCollection
    }
}

extension CollectionItem {
    var volumeReadingDescription: String {
        guard let readingVolume else { return "-" }
        return "\(readingVolume)"
    }
    
    var volumesOwnedDescription: String {
        guard !volumesOwned.isEmpty else { return "-" }
        return volumesOwned.map{ "\($0)" }.joined(separator: ",")
    }
    
    var volumeReadingString: String {
        guard let readingVolume else { return "" }
        return "\(readingVolume)"
    }
}
