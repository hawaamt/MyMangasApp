//
//  CustomFilterFactory.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import Foundation

struct CustomFilterFactory {
    
    static func makeView() -> CustomFilterView {
        let viewModel = CustomFilterViewModel(interactorGeneric: MangaInteractor(),
                                              interactorFilter: MangaInteractor())
        return CustomFilterView(viewModel: viewModel)
    }
}
