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
    func getAuthors() async throws -> [Author]
    func getDemographics() async throws -> [Demographic]
    func getGenres() async throws -> [Genre]
    func getThemes() async throws -> [Theme]
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
}


