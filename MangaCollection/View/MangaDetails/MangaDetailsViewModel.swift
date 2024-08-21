//
//  MangaDetailsViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 3/7/24.
//

import Foundation
import SwiftData

@Observable
final class MangaDetailsViewModel: ObservableObject {
    
    var manga: Manga
    var myMangaCollection: CollectionItem?
    var isEditingMyCollection: Bool = false
    
    init(manga: Manga) {
        self.manga = manga
    }
    
    func checkManagaIsInMyCollection(in context: ModelContext) {
        let predicate = #Predicate<CollectionItem> { item in
            item.manga.id == manga.id
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        do {
            let data = try context.fetch(descriptor)
            myMangaCollection = data.first
        } catch {
            myMangaCollection = nil
        }
    }
    
    func addToMyCollection(in context: ModelContext) {
        let newCollection = CollectionItem(id: UUID().uuidString,
                                           manga: manga)
        context.insert(newCollection)
        checkManagaIsInMyCollection(in: context)
    }
    
    func removeFromMyCollection(in context: ModelContext) {
        let predicate = #Predicate<CollectionItem> { item in
            item.manga.id == manga.id
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        do {
            guard let data = try context.fetch(descriptor).first else { return }
            context.delete(data)
        } catch {}
        checkManagaIsInMyCollection(in: context)
    }
    
    func saveEditing(reading: String, volumesOwned: [String]) {
        myMangaCollection?.volumeReading = Int(reading)
        myMangaCollection?.volumesOwned = volumesOwned.compactMap({ Int($0) })
    }
}
