//
//  MangaInteractor+FilteredBy.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

protocol MangaInteractorFilteredBy {
    func getMangaBy(_ mangaBy: MangaBy, with pagination: MangaPagination) async throws -> MangaPaginated
    func getMangaBy(_ filter: FilterBy, with pagination: MangaPagination) async throws -> MangaPaginated
    func getMangaBeginsWith(_ filter: String) async throws -> [Manga]
    func getMangaByID(_ mangaId: String) async throws -> Manga?
    func searchAuthor(with name: String) async throws -> [Author]
}

extension MangaInteractor: MangaInteractorFilteredBy {
    
    func getMangaBy(_ mangaBy: MangaBy, with pagination: MangaPagination) async throws -> MangaPaginated {
        let request = MangaByRequest(mangaBy: mangaBy, pagination: pagination)
        let response = try await networkService.perform(from: request)
        return response.manga
    }
    
    func getMangaBy(_ filter: FilterBy, with pagination: MangaPagination) async throws -> MangaPaginated {
        let request = MangaFilteredRequest(filterBy: filter, pagination: pagination)
        let response = try await networkService.perform(from: request)
        return response.manga
    }
    
    func getMangaBeginsWith(_ filter: String) async throws -> [Manga] {
        let request = MangaBeginsWithRequest(filter: filter)
        let response = try await networkService.perform(from: request)
        return response.compactMap { $0.manga }
    }
    
    func getMangaByID(_ mangaId: String) async throws -> Manga? {
        let request = MangaByIDRequest(mangaId: mangaId)
        let response = try await networkService.perform(from: request)
        return response?.manga
    }
    
    func searchAuthor(with name: String) async throws -> [Author] {
        let request = SearchAuthorRequest(author: name)
        let response = try await networkService.perform(from: request)
        return response.compactMap { $0.author }
    }
}
