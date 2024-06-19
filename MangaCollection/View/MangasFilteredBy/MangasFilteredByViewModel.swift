//
//  MangasFilteredByViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

@Observable
class MangasFilteredByViewModel {
    
    var mangas: [Manga] = []
    var isLoading: Bool = false
    
    private let mangaBy: MangaBy
    private let interactor: MangaInteractorFilteredBy
    
    private var pagination: MangaPagination
    
    init(mangaBy: MangaBy,
         interactor: MangaInteractorFilteredBy = MangaInteractor()) {
        self.mangaBy = mangaBy
        self.interactor = interactor
        self.pagination = MangaPagination(page: 1, per: 100)
    }
    
    @MainActor
    func loadData() async {
        // TODO: manage if page is the last
        do {
            isLoading = true
            let mangasPaginated = try await interactor.getMangaBy(mangaBy, with: pagination)
            mangas = mangasPaginated.items ?? []
            pagination = mangasPaginated.pagination
            isLoading = false
        } catch {
            print(error)
            isLoading = false
        }
    }
}
