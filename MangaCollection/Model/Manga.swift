//
//  Manga.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

// MARK: - Manga List Pagination
struct MangaPagination: Codable {
    let page: Int
    let per: Int
}

// MARK: - Manga Paginated
struct MangaPaginated: Codable {
    let pagination: MangaPagination
    let items: [Manga]?
}

// MARK: - Manga
struct Manga: Codable, Identifiable {
    let id: Int
    let title: String
    let volumes: Int?
    let chapters: Int?
    let url: String?
    let background: String?
    let score: Double?
    let startDate: String?
    let endDate: String?
    let genres: [Genre]
    let authors: [Author]
    let demographics: [Demographic]
    let themes: [Theme]
    let status: String?
    let sypnosis: String?
    let mainPicture: String?
    let titleJapanese: String?
    let titleEnglish: String?
}

// MARK: - Author
struct Author: Codable, Identifiable {
    let id: String
    let firstName: String
    let role: String
    let lastName: String
}

// MARK: - Demographic
struct Demographic: Codable, Identifiable {
    let id: String
    let demographic: String
}

// MARK: - Genre
struct Genre: Codable, Identifiable {
    let id: String
    let genre: String
}

// MARK: - Theme
struct Theme: Codable, Identifiable {
    let id: String
    let theme: String
}
