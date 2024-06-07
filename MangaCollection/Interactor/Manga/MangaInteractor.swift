//
//  MangaInteractor.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

protocol MangaInteractor {
    func getMangaList(with pagination: MangaPagination) async throws -> MangaPaginated
    func getMangaBest() async throws -> [Manga]
}

struct MangaInteractorImp: MangaInteractor {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }
    
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
}


