//
//  MangaCollectionApp.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import SwiftUI
import SwiftData

@main
struct MangaCollectionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CollectionItem.self)
    }
}
