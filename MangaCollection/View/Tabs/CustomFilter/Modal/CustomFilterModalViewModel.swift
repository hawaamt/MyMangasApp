//
//  CustomFilterModalViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import SwiftUI

struct FilterModalModel {
    
    // FILTER TYPE
    var filterBy: FilterByModel?
    
    // PICKERS DATA
    var authors: [Author] = []
    var genres: [Genre]
    var themes: [Theme]
    var demographics: [Demographic]
    
    // FILTER - PICKERS
    var genreSelected: Genre?
    var themeSelected: Theme?
    var demographicSelected: Demographic?
    
    // FILTER - AUTHOR
    var authorSelected: Author?
    var authorTitleSearch: String = ""
    var isSearchingAuthors: Bool = false
    
    // FILTER - TEXT
    var beginWithSelected: String = ""
    var containsSelected: String = ""
    var idSelected: String = ""
    
    // FILTER - CUSTOM
    var titleSelected: String = ""
    var customGenreSelected: Genre?
    var customDemographicSelected: Demographic?
    var customThemeSelected: Theme?
    var customGenres: [Genre] = []
    var customThemes: [Theme] = []
    var customDemographics: [Demographic] = []
}

@Observable
class CustomFilterModalViewModel {
    
    var model: FilterModalModel
    var errorToast: String = ""
    var showErrorToast: Bool = false
    
    private let interactorFilter: MangaInteractorFilteredBy
    var onAccept: (FilterByModel?) -> Void
    
    init(genres: [Genre],
         themes: [Theme],
         demographics: [Demographic],
         filterBy: FilterByModel?,
         interactorFilter: MangaInteractorFilteredBy = MangaInteractor(),
         onAccept: @escaping (FilterByModel?) -> Void) {
        self.model = FilterModalModel(genres: genres,
                                      themes: themes,
                                      demographics: demographics)
        self.onAccept = onAccept
        self.interactorFilter = interactorFilter
        self.model.filterBy = filterBy ?? .genre(genres.first)
        fillData()
    }
    
    func fillData() {
        guard let filterBy = model.filterBy else { return }
        
        model.genreSelected = model.genres.first
        model.themeSelected = model.themes.first
        model.demographicSelected = model.demographics.first
        model.customGenreSelected = model.genres.first
        model.customThemeSelected = model.themes.first
        model.customDemographicSelected = model.demographics.first
        
        switch filterBy {
        case .genre(let genre):
            model.genreSelected = genre ?? model.genres.first
        case .theme(let theme):
            model.themeSelected = theme ?? model.themes.first
        case .demographic(let demographic):
            model.demographicSelected = demographic ?? model.demographics.first
        case .author(let author):
            model.authorSelected = author
            model.authorTitleSearch = author?.fullName ?? ""
        case .beginWith(let beginWith):
            model.beginWithSelected = beginWith
        case .contains(let contains):
            model.containsSelected = contains
        case .id(let id):
            model.idSelected = id
        case .custom(let customFilterModel):
            model.customGenres = model.genres.filter({ customFilterModel?.searchGenres.contains($0.title) ?? false })
            model.customThemes = model.themes.filter({ customFilterModel?.searchThemes.contains($0.title) ?? false })
            model.customDemographics = model.demographics.filter({ customFilterModel?.searchDemographics.contains($0.title) ?? false })
        }
    }
    
    func submitSearchAuthors() {
        Task {
            await searchAuthors()
        }
    }
    
    @MainActor
    func searchAuthors() async {
        do {
            model.isSearchingAuthors = true
            model.authors = try await interactorFilter.searchAuthor(with: model.authorTitleSearch)
            model.isSearchingAuthors = false
        } catch {
            print(error)
            model.isSearchingAuthors = false
            model.authors = []
        }
    }
    
    func cleanFilters() {
        onAccept(nil)
    }
    
    func addGenreSelected() {
        guard let firstGenre = model.genres.first else { return }
        model.customGenres.append(model.customGenreSelected ?? firstGenre)
    }
    
    func addThemeSelected() {
        guard let firstTheme = model.themes.first else { return }
        model.customThemes.append(model.customThemeSelected ?? firstTheme)
    }
    
    func addDemographicSelected() {
        guard let firstDemographic = model.demographics.first else { return }
        model.customDemographics.append(model.customDemographicSelected ?? firstDemographic)
    }
    
    var isAddGenreButtonDisabled: Bool {
        guard !model.genres.isEmpty else { return true }
        
        if let customGenreSelected = model.customGenreSelected {
            return model.customGenres.contains(customGenreSelected)
        }
        
        if let first = model.genres.first {
            return model.customGenres.contains(first)
        }
        
        return false
    }
    
    var isAddThemeButtonDisabled: Bool {
        guard !model.themes.isEmpty else { return true }
        
        if let customThemeSelected = model.customThemeSelected {
            return model.customThemes.contains(customThemeSelected)
        }
        
        if let first = model.themes.first {
            return model.customThemes.contains(first)
        }
        
        return false
    }
    
    var isAddDemographicButtonDisabled: Bool {
        guard !model.demographics.isEmpty else { return true }
        
        if let customDemographicSelected = model.customDemographicSelected {
            return model.customDemographics.contains(customDemographicSelected)
        }
        
        if let first = model.demographics.first {
            return model.customDemographics.contains(first)
        }
        
        return true
    }
    
    func deleteGenre(in indexSet: IndexSet) {
        model.customGenres.remove(atOffsets: indexSet)
    }
    
    func deleteTheme(in indexSet: IndexSet) {
        model.customThemes.remove(atOffsets: indexSet)
    }
    
    func deleteDemographic(in indexSet: IndexSet) {
        model.customDemographics.remove(atOffsets: indexSet)
    }
    
    func acceptFilter() {
        guard let filterBy = model.filterBy else {
            onAccept(nil)
            return
        }
        
        switch filterBy {
        case .genre:
            onAccept(.genre(model.genreSelected))
        case .theme:
            onAccept(.theme(model.themeSelected))
        case .demographic:
            onAccept(.demographic(model.demographicSelected))
        case .author:
            onAccept(.author(model.authorSelected))
        case .beginWith:
            onAccept(.beginWith(model.beginWithSelected))
        case .contains:
            onAccept(.contains(model.containsSelected))
        case .id:
            onAccept(.id(model.idSelected))
        case .custom:
            let customFilterModel = CustomFilterModel(searchTitle: model.titleSelected,
                                                      searchDemographics: model.customDemographics.map { $0.demographic },
                                                      searchGenres: model.customGenres.map { $0.genre },
                                                      searchThemes: model.customThemes.map { $0.theme })
            onAccept(.custom(customFilterModel))
        }
    }
    
    var isAcceptDisabled: Bool {
        guard let filterBy = model.filterBy else {
            return true
        }
        
        switch filterBy {
        case .author:
            guard model.authorSelected != nil else {
                return true
            }
        case .beginWith:
            guard !model.beginWithSelected.isEmpty else {
                return true
            }
        case .contains:
            guard !model.containsSelected.isEmpty else {
                return true
            }
        case .id:
            guard !model.idSelected.isEmpty else {
                return true
            }
        default:
            return false
        }
        return false
    }
    
    private func showError(_ error: String) {
        errorToast = error
        showErrorToast = true
    }
}
