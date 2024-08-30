//
//  Manga.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import SwiftUI

enum AuthorRole: String, Codable {
    case story = "Story"
    case storyArt = "Story & Art"
    case art = "Art"
}

// MARK: - Manga List Pagination
struct MangaPagination: Codable {
    let page: Int
    let per: Int
}

extension MangaPagination {
    static var `default` =  MangaPagination(page: 1, per: 100)
}

// MARK: - Manga Paginated
struct MangaPaginated: Codable {
    let pagination: MangaPagination
    let items: [Manga]?
}

// MARK: - Manga
struct Manga: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let volumes: Int?
    let chapters: Int?
    let url: String?
    let background: String?
    let score: Double?
    let startDate: Date?
    let endDate: Date?
    let genres: [Genre]
    let authors: [Author]
    let demographics: [Demographic]
    let themes: [Theme]
    let status: MangaStatus?
    let sypnosis: String?
    let mainPicture: String?
    let titleJapanese: String?
    let titleEnglish: String?
}

enum MangaStatus: String, Codable {
    case inProgress = "currently_publishing"
    case finished
    
    var value: LocalizedStringKey {
        switch self {
            case .inProgress: LocalizedStringKey("status_inProgress")
            case .finished: LocalizedStringKey("status_finished")
        }
    }
    
    var color: Color {
        switch self {
        case .inProgress: Color(.finished)
            case .finished: Color(.success)
        }
    }
    
    var textColor: Color {
        switch self {
            case .inProgress: Color.white
            case .finished: Color.black
        }
    }
}

extension Manga {
    var writers: [Author]? {
        authors.filter { $0.role == AuthorRole.story }
    }
    
    var arts: [Author]? {
        authors.filter { $0.role == AuthorRole.art }
    }
    
    var storyArt: [Author]? {
        authors.filter { $0.role == AuthorRole.storyArt }
    }
}

// MARK: - Author
struct Author: Codable {
    let id: String
    let firstName: String?
    let role: AuthorRole?
    let lastName: String?
    
    var hasFirstName: Bool {
        guard let firstName else { return false }
        return !firstName.isEmpty
    }
    
    var hasLastName: Bool {
        guard let lastName else { return false }
        return !lastName.isEmpty
    }
    
    var name: String {
        if hasFirstName {
            return firstName!
        }
        if hasLastName {
            return lastName!
        }
        return "-"
    }
    
    var fullName: String {
        var names = [String]()
        if hasFirstName {
            names.append(firstName!)
        }
        if hasLastName {
            names.append(lastName!)
        }
        return names.isEmpty ? "-" : names.joined(separator: " ")
    }
}

// MARK: - Demographic
struct Demographic: Codable {
    let id: String
    let demographic: String
    
    var image: Image {
        Image(demographic)
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: String
    let genre: String
    
    var image: Image {
        Image(genre)
    }
}

// MARK: - Theme
struct Theme: Codable {
    let id: String
    let theme: String
    
    var image: Image {
        Image(theme)
    }
}

// MARK: - Manga by
enum MangaBy: Hashable {
    case genre(Genre)
    case theme(Theme)
    case demographic(Demographic)
    case author(Author)
    
    var title: String {
        switch self {
        case .genre(let genre):
            return "\(String(localized: "manga_by_genre")) \(genre.genre)"
        case .theme(let theme):
            return "\(String(localized: "manga_by_theme")) \(theme.theme)"
        case .demographic(let demographic):
            return "\(String(localized: "manga_by_demographic")) \(demographic.demographic)"
        case .author(let author):
            return "\(String(localized: "manga_by_author")) \(author.name)"
        }
    }
}
