//
//  CustomFilterViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import Foundation

@Observable
class CustomFilterViewModel {
    
    var authors: [Author] = []
    var genres: [Genre] = []
    var themes: [Theme] = []
    var demographics: [Demographic] = []
    var mangas: [Manga] = []
    
    var isShowingModal: Bool = false
    var listIsFull: Bool = false
    var isLoadingMangas: Bool = false
    var isLoadingAuthors: Bool = false
    var isLoadingDemographics: Bool = false
    var isLoadingGenres: Bool = false
    var isLoadingThemes: Bool = false
    
    private let interactorGeneric: MangaInteractorGeneric
    private let interactorFilter: MangaInteractorFilteredBy
    private var pagination: MangaPagination
    private var filterBy: FilterBy?
    
    init(interactorGeneric: MangaInteractorGeneric,
         interactorFilter: MangaInteractorFilteredBy) {
        self.interactorGeneric = interactorGeneric
        self.interactorFilter = interactorFilter
        self.pagination = MangaPagination(page: 1, per: 100)
    }
    
    var isFiltering: Bool {
        filterBy != nil
    }
    
    @MainActor
    func loadData() async {
        async let mangas: Void = loadMangas()
        async let authors: Void = loadAuthors()
        async let demographics: Void = loadDemographics()
        async let genres: Void = loadGenres()
        async let themes: Void = loadThemes()
        _ = await [mangas, authors, demographics, genres, themes]
    }
}

// MARK: - Load data
private extension CustomFilterViewModel {
    @MainActor
    func loadMangas() async {
        do {
            isLoadingMangas = true
            let mangasPaginated = try await interactorGeneric.getMangaList(with: pagination)
            mangas.append(contentsOf: mangasPaginated.items ?? [])
            pagination = mangasPaginated.pagination
            if mangas.count <= pagination.page * pagination.per && !listIsFull {
                listIsFull = true
            }
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
            authors = try await interactorGeneric.getAuthors()
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
            demographics = try await interactorGeneric.getDemographics()
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
            genres = try await interactorGeneric.getGenres()
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
            themes = try await interactorGeneric.getThemes()
            isLoadingThemes = false
        } catch {
            print(error)
            isLoadingThemes = false
        }
    }
}
