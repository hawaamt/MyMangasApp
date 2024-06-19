//
//  MangasFilteredByFactory.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

struct MangasFilteredByFactory {
    
    let mangasBy: MangaBy
    
    func makeView() -> MangasFilteredByView {
        let viewModel = MangasFilteredByViewModel(mangaBy: self.mangasBy,
                                                  interactor: MangaInteractor())
        return MangasFilteredByView(viewModel: viewModel)
    }
}
