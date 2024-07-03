//
//  MyCollectionView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 3/7/24.
//

import SwiftUI
import SwiftData

struct MyCollectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CollectionItem.manga.title) private var collection: [CollectionItem]
    
    var body: some View {
        List {
            ForEach(collection) { item in
                Text(item.manga.title)
            }
        }
    }
}

#Preview {
    MyCollectionView()
        .modelContainer(.preview)
}
