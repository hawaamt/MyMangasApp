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
    
    var collection: [CollectionItem]
    
    private let interactor: MangaInteractorGeneric
    
    init(interactor: MangaInteractorGeneric = MangaInteractor()) {
        self.interactor = interactor
        self.collection = []
    }
    
    @MainActor
    func updateCollection(in context: ModelContext) {
        fetchLocalCollection(in: context)
        Task {
            do {
                let items: [CollectionItem] = try await interactor.getMangas()
                deleteAllData(in: context)
                items.forEach { item in
                    context.insert(item)
                }
            } catch {
                print(error)
            }
        }
    }
}

private extension MyCollectionViewModel {
    
    func fetchLocalCollection(in context: ModelContext) {
        let fetchDescriptor = FetchDescriptor<CollectionItem>()
        do {
            let data = try context.fetch(fetchDescriptor)
            collection = data
        } catch {
            print(error)
        }
    }
    
    func deleteAllData(in context: ModelContext) {
        let fetchDescriptor = FetchDescriptor<CollectionItem>()
        do {
            let data = try context.fetch(fetchDescriptor)
            data.forEach { item in
                context.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
