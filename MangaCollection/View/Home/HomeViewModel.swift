//
//  HomeViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import Foundation

@Observable
class HomeViewModel {

    var bestMangas: [Manga] = []
    var authors: [Author] = []
    var demographics: [Demographic] = []
    var genres: [Genre] = []
    var themes: [Theme] = []
    
    var isLoadingMangas: Bool = false
    var isLoadingAuthors: Bool = false
    var isLoadingDemographics: Bool = false
    var isLoadingGenres: Bool = false
    var isLoadingThemes: Bool = false

    private let interactor: MangaInteractorGeneric
    
    init(interactor: MangaInteractorGeneric = MangaInteractor()) {
        self.interactor = interactor
        Task {
            await self.loadData()
        }
    }
    
    @MainActor
    func loadData() async {
        async let bestMangas: Void = loadBestMangas()
        async let authors: Void = loadAuthors()
        async let demographics: Void = loadDemographics()
        async let genres: Void = loadGenres()
        async let themes: Void = loadThemes()
        _ = await [bestMangas, authors, demographics, genres, themes]
    }
}

// MARK: - Load data
private extension HomeViewModel {
    @MainActor
    func loadBestMangas() async {
        do {
            isLoadingMangas = true
            bestMangas = try await interactor.getMangaBest()
            isLoadingMangas = false
        } catch {
            print(error)
            isLoadingMangas = false
        }
    }
    
    @MainActor
    func loadAuthors() async {
        do {
            isLoadingAuthors = true
            authors = try await interactor.getAuthors()
            isLoadingAuthors = false
        } catch {
            print(error)
            isLoadingAuthors = false
        }
    }
    
    @MainActor
    func loadDemographics() async {
        do {
            isLoadingDemographics = true
            demographics = try await interactor.getDemographics()
            isLoadingDemographics = false
        } catch {
            print(error)
            isLoadingDemographics = false
        }
    }
    
    @MainActor
    func loadGenres() async {
        do {
            isLoadingGenres = true
            genres = try await interactor.getGenres()
            isLoadingGenres = false
        } catch {
            print(error)
            isLoadingGenres = false
        }
    }
    
    @MainActor
    func loadThemes() async {
        do {
            isLoadingThemes = true
            themes = try await interactor.getThemes()
            isLoadingThemes = false
        } catch {
            print(error)
            isLoadingThemes = false
        }
    }
}
