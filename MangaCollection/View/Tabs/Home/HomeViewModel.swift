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
    
    var loadingMangasState: ScreenState = .idle
    var loadingAuthorsState: ScreenState = .idle
    var loadingDemographicsState: ScreenState = .idle
    var loadingGenresState: ScreenState = .idle
    var loadingThemesState: ScreenState = .idle

    private let interactor: MangaInteractorGeneric
    
    init(interactor: MangaInteractorGeneric = MangaInteractor()) {
        self.interactor = interactor
        if KeychainManager.shared.isUserLogged {
            loadData()
        }
    }
    
    func loadData() {
        Task {
            async let bestMangas: Void = loadBestMangas()
            async let authors: Void = loadAuthors()
            async let demographics: Void = loadDemographics()
            async let genres: Void = loadGenres()
            async let themes: Void = loadThemes()
            _ = await [bestMangas, authors, demographics, genres, themes]
        }
    }
}

// MARK: - Load data
extension HomeViewModel {
    
    @MainActor
    func loadBestMangas() async {
        do {
            loadingMangasState = .loading
            bestMangas = try await interactor.getMangaBest()
            loadingMangasState = bestMangas.isEmpty ? .empty : .loaded
        } catch {
            loadingMangasState = .error
        }
    }
    
    @MainActor
    func loadAuthors() async {
        do {
            loadingAuthorsState = .loading
            authors = try await interactor.getAuthors()
            loadingAuthorsState = authors.isEmpty ? .empty : .loaded
        } catch {
            loadingAuthorsState = .error
        }
    }
    
    @MainActor
    func loadDemographics() async {
        do {
            loadingDemographicsState = .loading
            demographics = try await interactor.getDemographics()
            loadingDemographicsState = demographics.isEmpty ? .empty : .loaded
        } catch {
            loadingDemographicsState = .error
        }
    }
    
    @MainActor
    func loadGenres() async {
        do {
            loadingGenresState = .loading
            genres = try await interactor.getGenres()
            loadingGenresState = genres.isEmpty ? .empty : .loaded
        } catch {
            loadingGenresState = .error
        }
    }
    
    @MainActor
    func loadThemes() async {
        do {
            loadingThemesState = .loading
            themes = try await interactor.getThemes()
            loadingThemesState = themes.isEmpty ? .empty : .loaded
        } catch {
            loadingThemesState = .error
        }
    }
}
