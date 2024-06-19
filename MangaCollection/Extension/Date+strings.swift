//
//  Date+strings.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 13/6/24.
//

import Foundation

extension Date {
    var year: String {
        "\(self.get(.year))"
    }
    
    private func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    private func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
