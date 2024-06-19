//
//  Demographic+Mocks.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import Foundation

extension Demographic {
    static var demo1 = Demographic(id: UUID().uuidString,
                                   demographic: "Seinen")
    
    static var demo2 = Demographic(id: UUID().uuidString,
                                   demographic: "Shounen")
    
    static var demo3 = Demographic(id: UUID().uuidString,
                                   demographic: "Shoujo")
    
    static var demo4 = Demographic(id: UUID().uuidString,
                                   demographic: "Josei")
    
    static var demo5 = Demographic(id: UUID().uuidString,
                                   demographic: "Kids")
    
    static var mockList: [Demographic] = [.demo1, .demo2, .demo3, .demo4, .demo5]
}
