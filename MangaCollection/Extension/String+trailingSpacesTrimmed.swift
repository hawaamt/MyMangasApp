//
//  String+trailingSpacesTrimmed.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 7/6/24.
//

import Foundation

extension String {
    var trailingSpacesTrimmed: String {
        var newString = self
        
        while newString.last?.isWhitespace == true {
            newString = String(newString.dropLast())
        }
        
        return newString
    }
}
