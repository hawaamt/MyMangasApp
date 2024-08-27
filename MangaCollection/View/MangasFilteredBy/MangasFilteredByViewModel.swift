//
//  MangasFilteredByViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

enum ScreenState {
    case idle
    case loading
    case loaded
    case empty
    case error
}

@Observable
class MangasFilteredByViewModel {
    
    var mangaBy: MangaBy
    var mangas: [Manga] = []
    var state: ScreenState = .idle
    
    var listIsFull: Bool = false
    
    private let interactor: MangaInteractorFilteredBy
    
    private var pagination: MangaPagination
    
    init(mangaBy: MangaBy,
         interactor: MangaInteractorFilteredBy = MangaInteractor()) {
        self.mangaBy = mangaBy
        self.interactor = interactor
        self.pagination = MangaPagination(page: 1, per: 100)
        Task {
            await loadData()
        }
    }
    
    @MainActor
    func loadData() async {
        do {
            state = .loading
            let mangasPaginated = try await interactor.getMangaBy(mangaBy, with: pagination)
            mangas.append(contentsOf: mangasPaginated.items ?? [])
            pagination = mangasPaginated.pagination
            state = mangas.isEmpty ? .empty : .loaded
            if mangas.count <= pagination.page * pagination.per && !listIsFull {
                listIsFull = true
            }
        } catch {
            print(error)
            state = .error
        }
    }
    
    @MainActor
    func reloadData() async {
        listIsFull = false
        pagination = MangaPagination(page: 1, per: 100)
        mangas = []
        await loadData()
    }
}
