//
//  CustomFilterModalViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import SwiftUI

enum FilterBy: CaseIterable, Identifiable, Hashable {
    
    case genre(Genre?)
    case theme(Theme?)
    case demographic(Demographic?)
    case author(Author?)
    case beginWith(String)
    case contains(String)
    case id(String)
    case custom(CustomFilterModel?)
    
    var title: LocalizedStringKey {
        switch self {
        case .genre: LocalizedStringKey("filterBy_genre")
        case .theme: LocalizedStringKey("filterBy_theme")
        case .demographic: LocalizedStringKey("filterBy_demographic")
        case .author: LocalizedStringKey("filterBy_author")
        case .beginWith: LocalizedStringKey("filterBy_beginWith")
        case .contains: LocalizedStringKey("filterBy_contains")
        case .id: LocalizedStringKey("filterBy_id")
        case .custom: LocalizedStringKey("filterBy_custom")
        }
    }
    
    var id: String {
        switch self {
        case .genre: "genre"
        case .theme: "theme"
        case .demographic: "demographic"
        case .author: "author"
        case .beginWith: "beginWith"
        case .contains: "contains"
        case .id: "id"
        case .custom: "custom"
        }
    }
    
    static func == (lhs: FilterBy, rhs: FilterBy) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static var allCases: [FilterBy] {
        return [.genre(nil), .theme(nil), .demographic(nil), .author(nil), .beginWith(""), .contains(""), .id(""), .custom(CustomFilterModel.default)]
    }
}

struct CustomFilterModel: Codable {
    var searchTitle: String
    var searchDemographics: [Demographic]
    var searchGenres: [Genre]
    var searchThemes: [Theme]
    
    static var `default` = CustomFilterModel(searchTitle: "",
                                             searchDemographics: [],
                                             searchGenres: [],
                                             searchThemes: [])
}

@Observable
class CustomFilterModalViewModel {
    
    var authors: [Author]
    var genres: [Genre]
    var themes: [Theme]
    var demographics: [Demographic]
    
    var filterBy: FilterBy? = .custom(nil)
    
    var genreSelected: Genre?
    var authorSelected: Author?
    var themeSelected: Theme?
    var demographicSelected: Demographic?
    
    var beginWithSelected: String = ""
    var containsSelected: String = ""
    var idSelected: String = ""
    
    var customFilterSelected: CustomFilterModel?
    var customGenreSelected: Genre?
    var customDemographicSelected: Demographic?
    var customThemeSelected: Theme?
    var customGenres: [Genre] = []
    var customThemes: [Theme] = []
    var customDemographics: [Demographic] = []
    
    init(authors: [Author],
         genres: [Genre],
         themes: [Theme],
         demographics: [Demographic]) {
        self.authors = authors
        self.genres = genres
        self.themes = themes
        self.demographics = demographics
    }
    
    func cleanFilters() {
        filterBy = .genre(nil)
        genreSelected = nil
        authorSelected = nil
        themeSelected = nil
        demographicSelected = nil
        beginWithSelected = ""
        containsSelected = ""
        idSelected = ""
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
}
