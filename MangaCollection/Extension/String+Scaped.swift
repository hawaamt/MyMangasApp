//
//  String+Scaped.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import Foundation

extension String {
    
    var unescaped: String {
        self.replacingOccurrences(of: "\"", with: "")
    }
}
