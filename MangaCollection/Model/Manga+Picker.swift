//
//  Manga+Picker.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 23/8/24.
//

import Foundation

protocol PickerList: Identifiable, Hashable {
    var title: String { get }
}

extension Author: PickerList {
    var title: String { name }
    
    static func == (lhs: Author, rhs: Author) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension Demographic: PickerList {
    var title: String { demographic }
    
    static func == (lhs: Demographic, rhs: Demographic) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension Genre: PickerList {
    var title: String { genre }
    
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension Theme: PickerList {
    var title: String { theme }
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
