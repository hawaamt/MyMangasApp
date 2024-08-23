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
            AppScreen.home.destination
                .tabItem {
                    AppScreen.home.label
                }
            AppScreen.myCollection.destination
                .tabItem {
                    AppScreen.myCollection.label
                }
            AppScreen.account.destination
                .tabItem {
                    AppScreen.account.label
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
            .navigationTitle("home_navigationTitle")
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
