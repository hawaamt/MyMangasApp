//
//  Theme+Mocks.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import Foundation

extension Theme {
    
    static var theme1 = Theme(id: UUID().uuidString,
                              theme: "Military")
    
    static var theme2 = Theme(id: UUID().uuidString,
                              theme: "Gore")
    
    static var theme3 = Theme(id: UUID().uuidString,
                              theme: "Romantic Subtext")
    
    static var theme4 = Theme(id: UUID().uuidString,
                              theme: "Anthropomorphic")
    
    static var theme5 = Theme(id: UUID().uuidString,
                              theme: "High Stakes Game")
    
    static var mockList: [Theme] = [.theme1, .theme2, .theme3, .theme4, .theme5]
}
