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
    var volumeReading: Int?
    var volumesOwned: [Int]
    var completeCollection: Bool
    
    init(id: String, 
         manga: Manga,
         volumeReading: Int? = nil,
         volumesOwned: [Int] = [],
         completeCollection: Bool = false) {
        self.id = id
        self.manga = manga
        self.volumeReading = volumeReading
        self.volumesOwned = volumesOwned
        self.completeCollection = completeCollection
    }
}

extension CollectionItem {
    var volumeReadingDescription: String {
        guard let volumeReading else { return "-" }
        return "\(volumeReading)"
    }
    
    var volumesOwnedDescription: String {
        guard !volumesOwned.isEmpty else { return "-" }
        return volumesOwned.map{ "\($0)" }.joined(separator: ",")
    }
    
    var volumeReadingString: String {
        guard let volumeReading else { return "" }
        return "\(volumeReading)"
    }
}
