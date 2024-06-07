//
//  MangaInteractorPreview.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import Foundation

struct MangaInteractorMock: MangaInteractor {
    
    func getMangaList(with pagination: MangaPagination) async throws -> MangaPaginated {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        return MangaPaginated(pagination: MangaPagination(page: 1, per: 10), items: Manga.mockList)
    }
    
    func getMangaBest() async throws -> [Manga] {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        return Manga.mockList
    }
}


