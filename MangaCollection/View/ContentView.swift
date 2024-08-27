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
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tabItem {
                        screen.label
                    }
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
