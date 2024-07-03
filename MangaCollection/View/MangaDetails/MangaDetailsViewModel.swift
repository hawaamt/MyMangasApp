//
//  MangaDetailsViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 3/7/24.
//

import Foundation

@Observable
final class MangaDetailsViewModel: ObservableObject {
    
    var manga: Manga
    
    init(manga: Manga) {
        self.manga = manga
    }
}
