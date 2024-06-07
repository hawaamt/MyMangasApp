//
//  HomeFactory.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import Foundation

struct HomeFactory {
    
    static func makeView() -> HomeView {
        let viewModel = HomeViewModel(interactor: MangaInteractorImp())
        return HomeView(viewModel: viewModel)
    }
}
