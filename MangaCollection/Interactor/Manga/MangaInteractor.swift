//
//  MangaInteractor.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import Foundation

struct MangaInteractor {
    
    let networkService: NetworkService
        
    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }
}
