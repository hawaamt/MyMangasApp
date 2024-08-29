//
//  MangaMyCollectionDTO+Models.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 29/8/24.
//

import Foundation

extension MangaMyCollectionDTO {
    var collectionItem: CollectionItem {
        CollectionItem(id: self.id,
                       manga: self.manga.manga,
                       readingVolume: self.readingVolume,
                       volumesOwned: self.volumesOwned,
                       completeCollection: self.completeCollection)
    }
}
