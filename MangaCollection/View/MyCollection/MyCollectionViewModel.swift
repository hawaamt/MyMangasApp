//
//  MyCollectionViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 4/7/24.
//

import Foundation
import SwiftData

@Observable
final class MyCollectionViewModel {
    
    func removeCollection(at indexSet: IndexSet,
                          in collection: [CollectionItem],
                          with context: ModelContext) {
        for index in indexSet {
            context.delete(collection[index])
        }
    }
}
