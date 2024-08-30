//
//  MangaDetailsViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 3/7/24.
//

import Foundation
import SwiftData

@Observable
final class MangaDetailsViewModel {
    
    var manga: Manga
    var myMangaCollection: CollectionItem?
    var isEditingMyCollection: Bool = false
    
    var isEditing: Bool = false
    var showErrorToast: Bool = false
    var errorToast: String = "my_collection_error"
    
    private let interactor: MangaInteractorGeneric
    
    init(manga: Manga,
         interactor: MangaInteractorGeneric = MangaInteractor()) {
        self.manga = manga
        self.interactor = interactor
    }
    
    @MainActor
    func getLocalCollection(in context: ModelContext) {
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
    
    @MainActor
    func addToMyCollection(in context: ModelContext) {
        Task {
            do {
                isEditing = true
                let mangaParams = MangaParams(manga: self.manga.id,
                                              completeCollection: false,
                                              volumesOwned: [],
                                              readingVolume: nil)
                let _ = try await interactor.addManga(mangaParams)
                let collectionItem = try await interactor.getManga(by: self.manga.id)
                context.insert(collectionItem)
                addMangaToMyCollection(in: context)
                isEditing = false
            } catch {
                print("addToMyCollection \(error)")
                isEditing = false
                showErrorToast = true
            }
        }
    }
    
    @MainActor
    private func addMangaToMyCollection(in context: ModelContext) {
        let predicate = #Predicate<CollectionItem> { item in
            item.manga.id == manga.id
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        do {
            let data = try context.fetch(descriptor)
            myMangaCollection = data.first
        } catch {
            print("addMangaToMyCollection \(error)")
        }
    }
    
    @MainActor
    func deleteMyCollectionManga(in context: ModelContext) {
        Task {
            do {
                isEditing = true
                let _ = try await interactor.deleteManga(manga.id)
                removeFromMyCollection(in: context)
                isEditing = false
            } catch {
                print("deleteMyCollectionManga \(error)")
                isEditing = false
                showErrorToast = true
            }
        }
    }
    
    @MainActor
    func saveEditing(reading: String, volumesOwned: [String], isCompleted: Bool) {
        guard let myMangaCollection else { return }
        Task {
            do {
                isEditing = true
                let mangaParams = MangaParams(manga: myMangaCollection.manga.id,
                                              completeCollection: isCompleted,
                                              volumesOwned: volumesOwned.compactMap({ Int($0) }),
                                              readingVolume: Int(reading))
                let _ = try await interactor.addManga(mangaParams)
                self.myMangaCollection?.readingVolume = Int(reading)
                self.myMangaCollection?.volumesOwned = volumesOwned.compactMap({ Int($0) })
                self.myMangaCollection?.completeCollection = isCompleted
                isEditing = false
            } catch {
                print("saveEditing \(error)")
                isEditing = false
                showErrorToast = true
            }
        }
    }
    
    @MainActor
    private func removeFromMyCollection(in context: ModelContext) {
        let predicate = #Predicate<CollectionItem> { item in
            item.manga.id == manga.id
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        do {
            guard let data = try context.fetch(descriptor).first else { return }
            self.myMangaCollection = nil
            context.delete(data)
        } catch {
            print("removeFromMyCollection \(error)")
        }
    }
}
