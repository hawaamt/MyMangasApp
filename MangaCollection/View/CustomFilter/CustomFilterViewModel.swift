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
    
    var state: ScreenState = .idle
    var listIsFull: Bool = false
    var isShowingModal: Bool = false
    
    var filterBy: FilterBy?
    
    private let interactorGeneric: MangaInteractorGeneric
    private let interactorFilter: MangaInteractorFilteredBy
    private var pagination: MangaPagination
    
    init(interactorGeneric: MangaInteractorGeneric,
         interactorFilter: MangaInteractorFilteredBy) {
        self.interactorGeneric = interactorGeneric
        self.interactorFilter = interactorFilter
        self.pagination = MangaPagination(page: 1, per: 100)
        Task {
            await loadData()
        }
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
    
    func onAcceptFilter(_ filterBy: FilterBy?) {
        self.filterBy = filterBy
        Task {
            self.mangas = []
            self.pagination = MangaPagination(page: 1, per: 100)
            await loadMangas()
        }
    }
}

// MARK: - Load data
private extension CustomFilterViewModel {
    @MainActor
    func loadMangas() async {
        do {
            state = .loading
            guard let filterBy else {
                let mangaPaginated = try await interactorGeneric.getMangaList(with: pagination)
                fillMangasList(mangaPaginated.items ?? [], with: mangaPaginated.pagination)
                return
            }
            
            switch filterBy {
            case .id(let mangaId):
                let manga = try await interactorFilter.getMangaByID(mangaId)
                guard let manga else {
                    fillMangasList([])
                    return
                }
                fillMangasList([manga])
            case .beginWith(let filter):
                let mangas = try await interactorFilter.getMangaBeginsWith(filter)
                fillMangasList(mangas)
            default:
                let mangaPaginated = try await interactorFilter.getMangaBy(filterBy, with: pagination)
                fillMangasList(mangaPaginated.items ?? [], with: mangaPaginated.pagination)
            }
        } catch {
            print("ERROR: \(error)")
            state = .error
        }
    }
    
    private func fillMangasList(_ mangas: [Manga], with pagination: MangaPagination? = nil) {
        self.mangas.append(contentsOf: mangas)
        state = mangas.isEmpty ? .empty : .loaded
        
        guard let pagination else { return }
        self.pagination = pagination
        if self.mangas.count <= pagination.page * pagination.per,
           !listIsFull {
            listIsFull = true
        }
    }
    
    @MainActor
    func loadAuthors() async {
        do {
            authors = try await interactorGeneric.getAuthors()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func loadDemographics() async {
        do {
            demographics = try await interactorGeneric.getDemographics()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func loadGenres() async {
        do {
            genres = try await interactorGeneric.getGenres()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func loadThemes() async {
        do {
            themes = try await interactorGeneric.getThemes()
        } catch {
            print(error)
        }
    }
}
