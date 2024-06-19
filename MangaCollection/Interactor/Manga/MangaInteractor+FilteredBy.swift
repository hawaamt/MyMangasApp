//
//  MangaInteractor+FilteredBy.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

protocol MangaInteractorFilteredBy {
    func getMangaBy(_ mangaBy: MangaBy, with pagination: MangaPagination) async throws -> MangaPaginated
}

extension MangaInteractor: MangaInteractorFilteredBy {
    
    func getMangaBy(_ mangaBy: MangaBy, with pagination: MangaPagination) async throws -> MangaPaginated {
        let request = MangaByRequest(mangaBy: mangaBy, pagination: pagination)
        let response = try await networkService.perform(from: request)
        return response.manga
    }
}
