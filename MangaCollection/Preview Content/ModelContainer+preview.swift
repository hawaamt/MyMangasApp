//
//  ModelContainer+preview.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 3/7/24.
//

import Foundation
import SwiftData

extension ModelContainer {
    static let preview: ModelContainer = {
        let schema = Schema([CollectionItem.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])

        Task { @MainActor in
            let collection1 = CollectionItem(id: UUID().uuidString, manga: Manga.manga1)
            let collection2 = CollectionItem(id: UUID().uuidString, manga: Manga.manga2)
            let collection3 = CollectionItem(id: UUID().uuidString, manga: Manga.manga3)
            container.mainContext.insert(collection1)
            container.mainContext.insert(collection2)
            container.mainContext.insert(collection3)
        }

        return container
    }()
}

