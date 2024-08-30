//
//  ManagaInteractorBy.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

struct MangaInteractorFilteredByMock: MangaInteractorFilteredBy {
    
    let stateToTest: ScreenState
    
    func getMangaBy(_ mangaBy: MangaBy, with pagination: MangaPagination) async throws -> MangaPaginated {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        switch stateToTest {
        case .idle, .loading, .empty:
            return MangaPaginated(pagination: MangaPagination(page: 1, per: 10), items: [])
        case .loaded:
            return MangaPaginated(pagination: MangaPagination(page: 1, per: 10), items: Manga.mockList)
        case .error:
            throw NetworkError.status(404)
        }
    }
    
    func getMangaBy(_ filter: FilterByModel, with pagination: MangaPagination) async throws -> MangaPaginated {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        switch stateToTest {
        case .idle, .loading, .empty:
            return MangaPaginated(pagination: MangaPagination(page: 1, per: 10), items: [])
        case .loaded:
            return MangaPaginated(pagination: MangaPagination(page: 1, per: 10), items: Manga.mockList)
        case .error:
            throw NetworkError.status(404)
        }
    }
    
    func getMangaBeginsWith(_ filter: String) async throws -> [Manga] {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        switch stateToTest {
        case .idle, .loading, .empty:
            return []
        case .loaded:
            return Manga.mockList
        case .error:
            throw NetworkError.status(404)
        }
    }
    
    func getMangaByID(_ mangaId: String) async throws -> Manga? {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        switch stateToTest {
        case .idle, .loading, .empty:
            return nil
        case .loaded:
            return Manga.manga1
        case .error:
            throw NetworkError.status(404)
        }
    }
    
    func searchAuthor(with name: String) async throws -> [Author] {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        switch stateToTest {
        case .idle, .loading, .empty:
            return []
        case .loaded:
            return Author.mockList
        case .error:
            throw NetworkError.status(404)
        }
    }
}
