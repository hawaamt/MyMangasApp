//
//  JSONEncodable.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

extension Encodable {
    
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
