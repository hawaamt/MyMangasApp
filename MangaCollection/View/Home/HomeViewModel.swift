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
    var isLoading: Bool = false

    private let interactor: MangaInteractor
    
    init(interactor: MangaInteractor = MangaInteractorImp()) {
        self.interactor = interactor
    }
    
    @MainActor
    func loadBestMangas() async {
        do {
            isLoading = true
            bestMangas = try await interactor.getMangaBest()
            isLoading = false
        } catch {
            print(error)
            isLoading = false
        }
    }
}
