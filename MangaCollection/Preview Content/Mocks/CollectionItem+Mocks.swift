//
//  CollectionItem+Mocks.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 29/8/24.
//

import Foundation

extension CollectionItem {
    static var collectionItem1 = CollectionItem(id: "1", manga: Manga.manga1)
    
    static var collectionItem2 = CollectionItem(id: "2",
                                                manga: Manga.manga2,
                                                readingVolume: 2,
                                                volumesOwned: [1, 2, 3])
    
    static var collectionItem3 = CollectionItem(id: "3", 
                                                manga: Manga.manga3,
                                                readingVolume: 2,
                                                volumesOwned: [],
                                                completeCollection: true)
    
    static var mockList: [CollectionItem] = [collectionItem1, collectionItem2, collectionItem3]
}
