//
//  ManagaInteractorBy.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

struct MangaInteractorFilteredByMock: MangaInteractorFilteredBy {
    func getMangaBy(_ mangaBy: MangaBy, with pagination: MangaPagination) async throws -> MangaPaginated {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        return MangaPaginated(pagination: MangaPagination(page: 1, per: 10), items: Manga.mockList)
    }
}
