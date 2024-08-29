//
//  MangaInteractorPreview.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import Foundation

struct MangaInteractorGenericMock: MangaInteractorGeneric {
    
    func getMangaList(with pagination: MangaPagination) async throws -> MangaPaginated {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        return MangaPaginated(pagination: MangaPagination(page: 1, per: 10), items: Manga.mockList)
    }
    
    func getMangaBest() async throws -> [Manga] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return Manga.mockList
    }
    
    func getAuthors() async throws -> [Author] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return Author.mockList
    }
    
    func getDemographics() async throws -> [Demographic] {
        try await Task.sleep(nanoseconds: 2_500_000_000)
        return Demographic.mockList
    }
    
    func getGenres() async throws -> [Genre] {
        try await Task.sleep(nanoseconds: 2_300_000_000)
        return Genre.mockList
    }
    
    func getThemes() async throws -> [Theme] {
        try await Task.sleep(nanoseconds: 1_500_000_000)
        return Theme.mockList
    }
    
    func addManga(_ manga: MangaParams) async throws -> String {
        try await Task.sleep(nanoseconds: 1_500_000_000)
        return ""
    }
    
    func getMangas() async throws -> [CollectionItem] {
        try await Task.sleep(nanoseconds: 1_500_000_000)
        return CollectionItem.mockList
    }
    
    func getManga(by mangaId: Int) async throws -> CollectionItem {
        try await Task.sleep(nanoseconds: 1_500_000_000)
        return CollectionItem.collectionItem1
    }
    
    func deleteManga(_ mangaId: Int) async throws -> String {
        try await Task.sleep(nanoseconds: 1_500_000_000)
        return ""
    }
}


