//
//  MangaInteractor+Generic.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

protocol MangaInteractorGeneric {
    func getMangaList(with pagination: MangaPagination) async throws -> MangaPaginated
    func getMangaBest() async throws -> [Manga]
    func getAuthors() async throws -> [Author]
    func getDemographics() async throws -> [Demographic]
    func getGenres() async throws -> [Genre]
    func getThemes() async throws -> [Theme]
    func addManga(_ manga: MangaParams) async throws -> String
    func getMangas() async throws -> [CollectionItem]
    func getManga(by mangaId: Int) async throws -> CollectionItem
    func deleteManga(_ mangaId: Int) async throws -> String
}

extension MangaInteractor: MangaInteractorGeneric {
    
    func getMangaList(with pagination: MangaPagination) async throws -> MangaPaginated {
        let request = MangaListRequest(pagination: pagination)
        let response = try await networkService.perform(from: request)
        return response.manga
    }
    
    func getMangaBest() async throws -> [Manga] {
        let request = MangaBestRequest()
        let response = try await networkService.perform(from: request)
        return response.manga.items ?? []
    }
    
    func getAuthors() async throws -> [Author] {
        let request = AuthorsRequest()
        let response = try await networkService.perform(from: request)
        return response.compactMap { $0.author }
    }
    
    func getDemographics() async throws -> [Demographic] {
        let request = DemographicsRequest()
        let response = try await networkService.perform(from: request)
        return response.compactMap { $0.demographic }
    }
    
    func getGenres() async throws -> [Genre] {
        let request = GenresRequest()
        let response = try await networkService.perform(from: request)
        return response.compactMap { $0.genre }
    }
    
    func getThemes() async throws -> [Theme] {
        let request = ThemesRequest()
        let response = try await networkService.perform(from: request)
        return response.compactMap { $0.theme }
    }
    
    func addManga(_ manga: MangaParams) async throws -> String {
        let request = AddMangaToMyCollectionRequest(manga: manga)
        let response = try await networkService.perform(from: request)
        return response
    }
    
    func getMangas() async throws -> [CollectionItem] {
        let request = MyMangaCollectionRequest()
        let response = try await networkService.perform(from: request)
        return response.compactMap { $0.collectionItem }
    }
    
    func getManga(by mangaId: Int) async throws -> CollectionItem {
        let request = MyMangaCollectionItemRequest(mangaId: mangaId)
        let response = try await networkService.perform(from: request)
        return response.collectionItem
    }
    
    func deleteManga(_ mangaId: Int) async throws -> String {
        let request = DeleteMyMangaCollectionRequest(mangaId: mangaId)
        let response = try await networkService.perform(from: request)
        return response
    }
}


