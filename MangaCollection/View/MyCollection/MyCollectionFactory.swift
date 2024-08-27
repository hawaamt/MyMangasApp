//
//  MyCollectionFactory.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 4/7/24.
//

import Foundation

struct MyCollectionFactory {
    
    static func makeView() -> MyCollectionView {
        let viewModel = MyCollectionViewModel()
        return MyCollectionView(viewModel: viewModel)
    }
}
