//
//  MangaInteractor.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

protocol MangaInteractor {
    func getMangaList(with pagination: MangaPagination) async throws -> MangaPaginated
}

struct MangaInteractorImp: MangaInteractor {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func getMangaList(with pagination: MangaPagination) async throws -> MangaPaginated {
        print(pagination)
        let request = MangaListRequest(pagination: pagination)
        let response = try await networkService.perform(from: request)
        return response.manga
    }
}


