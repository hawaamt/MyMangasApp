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
    @State private var accessViewModel = AccessViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(accessViewModel)
        }
        .modelContainer(for: CollectionItem.self)
    }
}
