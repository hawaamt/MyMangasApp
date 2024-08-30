//
//  LocalDataManager.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 30/8/24.
//

import Foundation
import SwiftData

class LocalDataManager {
    
    static var shared = LocalDataManager()
    
    private let interactor: MangaInteractorGeneric
    
    init(interactor: MangaInteractorGeneric = MangaInteractor()) {
        self.interactor = interactor
    }
    
    @MainActor
    func syncLocalWithRemote(context: ModelContext) async {
        do {
            let remoteItems = try await interactor.getMangas()
            syncData(remoteItems: remoteItems, context: context)
        } catch {
            print(error)
        }
    }

    @MainActor
    private func syncData(remoteItems: [CollectionItem], context: ModelContext) {
        let request = FetchDescriptor<CollectionItem>()
        do {
            let localItems = try context.fetch(request)

            // Determine items to delete locally
            let itemsToDelete = localItems.filter { !remoteItems.contains($0) }

            // Determine items to add or update
            let itemsToAdd = remoteItems.filter { !localItems.contains($0) }
            let itemsToUpdate = remoteItems.filter { localItems.contains($0) }

            // Deletion local items needed
            for item in itemsToDelete {
                context.delete(item)
            }

            // Add local items needed
            for item in itemsToAdd {
                let newItem = CollectionItem(id: item.id,
                                             manga: item.manga,
                                             readingVolume: item.readingVolume,
                                             volumesOwned: item.volumesOwned,
                                             completeCollection: item.completeCollection)
                context.insert(newItem)
            }

            for item in itemsToUpdate {
                if let localItem = localItems.first(where: { $0.id == item.id }) {
                    localItem.manga = item.manga
                    localItem.readingVolume = item.readingVolume
                    localItem.volumesOwned = item.volumesOwned
                    localItem.completeCollection = item.completeCollection
                }
            }
        } catch {
            print("Error on get local items \(error)")
        }
    }
}
