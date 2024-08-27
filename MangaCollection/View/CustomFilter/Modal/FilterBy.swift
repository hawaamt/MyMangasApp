//
//  FilterBy.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 23/8/24.
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
