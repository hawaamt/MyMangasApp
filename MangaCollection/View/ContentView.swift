//
//  ContentView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSize
    
    @State private var screen: AppScreen? = .home
    
    private var isCompact: Bool { horizontalSize == .compact }
    
    var body: some View {
        if isCompact {
            tabView
        } else {
            sidebarView
        }
    }
    
    private var tabView: some View {
        TabView {
            HomeFactory
                .makeView()
                .tabItem {
                    Label("tab_home", systemImage: "house")
                }
            MyCollectionFactory()
                .makeView()
                .tabItem {
                    Label("tab_myCollection", systemImage: "books.vertical")
                }
            VStack {
                Text("tab_myAccount")
            }
            .tabItem {
                Label("tab_myAccount", systemImage: "person")
            }
        }
    }
    
    private var sidebarView: some View {
        NavigationSplitView {
            List(AppScreen.allCases, selection: $screen) { screen in
                NavigationLink(value: screen) {
                    screen.label
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Manga App!")
        } detail: {
            if let screen {
                screen.destination
            } else {
                AppScreen.home.destination
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(.preview)
}
