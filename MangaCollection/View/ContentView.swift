//
//  ContentView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        TabView {
            HomeFactory
                .makeView()
                .tabItem {
                    Label("tab_home", systemImage: "house")
                }
            MyCollectionView()
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
}

#Preview {
    ContentView()
        .modelContainer(.preview)
}
