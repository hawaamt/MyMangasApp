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
    
    private let interactor: MangaInteractorGeneric
    
    init(interactor: MangaInteractorGeneric = MangaInteractor()) {
        self.interactor = interactor
    }
    
    @MainActor
    func updateCollection(in context: ModelContext) {
        Task {
            do {
                let items: [CollectionItem] = try await interactor.getMangas()
                print(items)
                items.forEach { item in
                    if mangaIsInMyCollection(item, in: context) {
                        context.insert(item)
                    } else {
                        updateMangaItemCollection(item, in: context)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

private extension MyCollectionViewModel {
    func mangaIsInMyCollection(_ collectionItem: CollectionItem, in context: ModelContext) -> Bool {
        let collectionId = collectionItem.id
        let predicate = #Predicate<CollectionItem> { item in
            item.id == collectionId
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        do {
            let _ = try context.fetch(descriptor)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func updateMangaItemCollection(_ collectionItem: CollectionItem, in context: ModelContext) {
        let collectionId = collectionItem.id
        let predicate = #Predicate<CollectionItem> { item in
            item.id == collectionId
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        do {
            let data = try context.fetch(descriptor)
            guard let myCollectionItem = data.first else { return }
            myCollectionItem.readingVolume = collectionItem.readingVolume
            myCollectionItem.volumesOwned = collectionItem.volumesOwned
            myCollectionItem.completeCollection = collectionItem.completeCollection
        } catch {
            print(error)
        }
    }
}
