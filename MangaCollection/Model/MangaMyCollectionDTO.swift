//
//  MangaMyCollectionDTO.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 29/8/24.
//

import Foundation

struct MangaMyCollectionDTO: Codable {
    let id: String
    let readingVolume: Int?
    let volumesOwned: [Int]
    let completeCollection: Bool
    let manga: MangaItemDTO
}
