//
//  CustomFilterModalViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import SwiftUI

struct CustomFilterModel: Codable {
    var searchTitle: String
    var searchDemographics: [String]
    var searchGenres: [String]
    var searchThemes: [String]
    var searchContains: Bool = true
    
    static var `default` = CustomFilterModel(searchTitle: "",
                                             searchDemographics: [],
                                             searchGenres: [],
                                             searchThemes: [],
                                             searchContains: true)
}

@Observable
class CustomFilterModalViewModel {
    // PICKERS DATA
    var authors: [Author] = []
    var genres: [Genre]
    var themes: [Theme]
    var demographics: [Demographic]
    
    // FILTER TYPE
    var filterBy: FilterBy?
    
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
    
    // TOAST
    var errorToast: LocalizedStringKey = ""
    var showErrorToast: Bool = false
    
    private let interactorFilter: MangaInteractorFilteredBy
    var onAccept: (FilterBy?) -> Void
    
    init(genres: [Genre],
         themes: [Theme],
         demographics: [Demographic],
         filterBy: FilterBy?,
         interactorFilter: MangaInteractorFilteredBy = MangaInteractor(),
         onAccept: @escaping (FilterBy?) -> Void) {
        self.genres = genres
        self.themes = themes
        self.demographics = demographics
        self.onAccept = onAccept
        self.interactorFilter = interactorFilter
        self.filterBy = filterBy ?? .genre(genres.first)
        fillData()
    }
    
    func fillData() {
        guard let filterBy else { return }
        
        genreSelected = genres.first
        themeSelected = themes.first
        demographicSelected = demographics.first
        customGenreSelected = genres.first
        customThemeSelected = themes.first
        customDemographicSelected = demographics.first
        
        switch filterBy {
        case .genre(let genre):
            genreSelected = genre ?? genres.first
        case .theme(let theme):
            themeSelected = theme ?? themes.first
        case .demographic(let demographic):
            demographicSelected = demographic ?? demographics.first
        case .author(let author):
            authorSelected = author
            authorTitleSearch = author?.fullName ?? ""
        case .beginWith(let beginWith):
            beginWithSelected = beginWith
        case .contains(let contains):
            containsSelected = contains
        case .id(let id):
            idSelected = id
        case .custom(let customFilterModel):
            customGenres = genres.filter({ customFilterModel?.searchGenres.contains($0.title) ?? false })
            customThemes = themes.filter({ customFilterModel?.searchThemes.contains($0.title) ?? false })
            customDemographics = demographics.filter({ customFilterModel?.searchDemographics.contains($0.title) ?? false })
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
            isSearchingAuthors = true
            authors = try await interactorFilter.searchAuthor(with: authorTitleSearch)
            isSearchingAuthors = false
        } catch {
            print(error)
            isSearchingAuthors = false
            authors = []
        }
    }
    
    func cleanFilters() {
        onAccept(nil)
    }
    
    func addGenreSelected() {
        guard let firstGenre = genres.first else { return }
        customGenres.append(customGenreSelected ?? firstGenre)
    }
    
    func addThemeSelected() {
        guard let firstTheme = themes.first else { return }
        customThemes.append(customThemeSelected ?? firstTheme)
    }
    
    func addDemographicSelected() {
        guard let firstDemographic = demographics.first else { return }
        customDemographics.append(customDemographicSelected ?? firstDemographic)
    }
    
    var isAddGenreButtonDisabled: Bool {
        guard !genres.isEmpty else { return true }
        
        if let customGenreSelected {
            return customGenres.contains(customGenreSelected)
        }
        
        if let first = genres.first {
            return customGenres.contains(first)
        }
        
        return false
    }
    
    var isAddThemeButtonDisabled: Bool {
        guard !themes.isEmpty else { return true }
        
        if let customThemeSelected {
            return customThemes.contains(customThemeSelected)
        }
        
        if let first = themes.first {
            return customThemes.contains(first)
        }
        
        return false
    }
    
    var isAddDemographicButtonDisabled: Bool {
        guard !demographics.isEmpty else { return true }
        
        if let customDemographicSelected {
            return customDemographics.contains(customDemographicSelected)
        }
        
        if let first = demographics.first {
            return customDemographics.contains(first)
        }
        
        return true
    }
    
    func deleteGenre(in indexSet: IndexSet) {
        customGenres.remove(atOffsets: indexSet)
    }
    
    func deleteTheme(in indexSet: IndexSet) {
        customThemes.remove(atOffsets: indexSet)
    }
    
    func deleteDemographic(in indexSet: IndexSet) {
        customDemographics.remove(atOffsets: indexSet)
    }
    
    func acceptFilter() {
        guard let filterBy else {
            onAccept(nil)
            return
        }
        
        switch filterBy {
        case .genre:
            onAccept(.genre(genreSelected))
        case .theme:
            onAccept(.theme(themeSelected))
        case .demographic:
            onAccept(.demographic(demographicSelected))
        case .author:
            onAccept(.author(authorSelected))
        case .beginWith:
            onAccept(.beginWith(beginWithSelected))
        case .contains:
            onAccept(.contains(containsSelected))
        case .id:
            onAccept(.id(idSelected))
        case .custom:
            let customFilterModel = CustomFilterModel(searchTitle: titleSelected,
                                                      searchDemographics: customDemographics.map { $0.demographic },
                                                      searchGenres: customGenres.map { $0.genre },
                                                      searchThemes: customThemes.map { $0.theme })
            onAccept(.custom(customFilterModel))
        }
    }
    
    var isAcceptDisabled: Bool {
        guard let filterBy else {
            return true
        }
        
        switch filterBy {
        case .author:
            guard authorSelected != nil else {
                return true
            }
        case .beginWith:
            guard !beginWithSelected.isEmpty else {
                return true
            }
        case .contains:
            guard !containsSelected.isEmpty else {
                return true
            }
        case .id:
            guard !idSelected.isEmpty else {
                return true
            }
        default:
            return false
        }
        return false
    }
    
    private func showError(_ error: String) {
        errorToast = LocalizedStringKey(error)
        showErrorToast = true
    }
}
