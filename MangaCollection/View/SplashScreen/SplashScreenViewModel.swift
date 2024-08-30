//
//  SplashScreenViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 30/8/24.
//

import Foundation
import SwiftData

@Observable
class SplashScreenViewModel {
    
    var refreshabled: Bool = false
    
    private let localStorage: LocalDataManager
    
    init(localStorage: LocalDataManager = LocalDataManager.shared) {
        self.localStorage = localStorage
    }
    
    @MainActor
    func syncLocalWithRemote(in context: ModelContext) {
        Task {
            await localStorage.syncLocalWithRemote(context: context)
            refreshabled = true
        }
    }
}
