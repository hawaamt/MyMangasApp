//
//  CustomFilterModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 30/8/24.
//

import Foundation

struct CustomFilterModel: Codable {
    var searchTitle: String
    var searchDemographics: [String]
    var searchGenres: [String]
    var searchThemes: [String]
    var searchContains: Bool = true
    
    static var `default` = CustomFilterModel(
        searchTitle: "",
        searchDemographics: [],
        searchGenres: [],
        searchThemes: [],
        searchContains: true
    )
}
