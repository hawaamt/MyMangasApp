//
//  MangaDTO.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

// MARK: - Manga List
struct MangaListDTO: Codable {
    let metadata: MangaMetaDTO
    let items: [MangaItemDTO]?
}

// MARK: - Metadata
struct MangaMetaDTO: Codable {
    let per: Int
    let total: Int
    let page: Int
}

// MARK: - Item
struct MangaItemDTO: Codable {
    let id: Int
    let title: String
    let volumes: Int?
    let chapters: Int?
    let url: String?
    let background: String?
    let score: Double?
    let startDate: String?
    let endDate: String?
    let genres: [GenreDTO]
    let authors: [AuthorDTO]
    let demographics: [DemographicDTO]
    let themes: [ThemeDTO]
    let status: String?
    let sypnosis: String?
    let mainPicture: String?
    let titleJapanese: String?
    let titleEnglish: String?
}

// MARK: - Author
struct AuthorDTO: Codable {
    let id: String
    let firstName: String
    let role: String
    let lastName: String
}

// MARK: - Demographic
struct DemographicDTO: Codable {
    let id: String
    let demographic: String
}

// MARK: - Genre
struct GenreDTO: Codable {
    let id: String
    let genre: String
}

// MARK: - Theme
struct ThemeDTO: Codable {
    let id: String
    let theme: String
}
