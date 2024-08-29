//
//  AppScreen.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import SwiftUI

enum AppScreen: CaseIterable, Identifiable {
    case home
    case filter
    case myCollection
    case account

    var label: Label<Text, Image> {
        switch self {
        case .home: Label("tab_home", systemImage: "house")
        case .filter: Label("tab_filter", systemImage: "line.3.horizontal.decrease.circle.fill")
        case .myCollection: Label("tab_myCollection", systemImage: "books.vertical")
        case .account: Label("tab_myAccount", systemImage: "person")
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .home: 
            HomeFactory.makeView()
                .tag(self.id)
        case .filter: 
            CustomFilterFactory.makeView()
                .tag(self.id)
        case .myCollection: 
            MyCollectionFactory.makeView()
                .tag(self.id)
        case .account: 
            MyAccountView()
                .tag(self.id)
        }
    }

    var id: AppScreen { self }
}
