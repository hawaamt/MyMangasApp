//
//  Author+Mocks.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import Foundation

extension Author {
    static var placeholder = Author(id: "placeholder",
                                    firstName: "Placeholder",
                                    role: .art,
                                    lastName: "Placeholder")
    
    static var author1 = Author(id: "AE354A62-1A8C-496B-A816-1ED1E4ED34FA",
                                firstName: "Natsuki",
                                role: .story,
                                lastName: "Takaya")
    
    static var author2 = Author(id: "2AE354A62-1A8C-496B-A816-1ED1E4ED34FA",
                                firstName: nil,
                                role: .art,
                                lastName: "HERO")
    
    static var author3 = Author(id: "3AE354A62-1A8C-496B-A816-1ED1E4ED34FA",
                                firstName: "Yoshiyuki",
                                role: .art,
                                lastName: "Sadamoto")
    
    static var author4 = Author(id: "4AE354A62-1A8C-496B-A816-1ED1E4ED34FA",
                                firstName: "Daisuke",
                                role: .storyArt,
                                lastName: "Hagiwara")
    
    static var author5 = Author(id: "5AE354A62-1A8C-496B-A816-1ED1E4ED34FA",
                                firstName: "Osamu",
                                role: .storyArt,
                                lastName: "Tezuka")
    
    static var author6 = Author(id: "6AE354A62-1A8C-496B-A816-1ED1E4ED34FA",
                                firstName: "Sumomo",
                                role: .art,
                                lastName: "Yumeka")
    
    static var author7 = Author(id: "7AE354A62-1A8C-496B-A816-1ED1E4ED34FA",
                                firstName: "Bisco",
                                role: .story,
                                lastName: "Hatori")
    
    static var author8 = Author(id: "8AE354A62-1A8C-496B-A816-1ED1E4ED34FA",
                                firstName: "",
                                role: .story,
                                lastName: "Rifujin na Magonote")
    
    static var mockList: [Author] = [.author1, .author2, .author3, .author4, .author5, .author6, .author7, .author8]
}
