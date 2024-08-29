//
//  ContentView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(AccessViewModel.self) private var accessViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSize
    
    @State var homeViewModel: HomeViewModel = HomeViewModel()
    @State private var screen: AppScreen? = .home
    
    @State var tabSelected: AppScreen = .home
    
    private var isCompact: Bool { horizontalSize == .compact }
    
    var body: some View {
        @Bindable var accessViewModel = accessViewModel
        content
            .fullScreenCover(isPresented: $accessViewModel.isNotLogged) {
                homeViewModel.loadData()
            } content: {
                AccessView()
                    .environment(accessViewModel)
            }
            .onChange(of: accessViewModel.isNotLogged) { _, newValue in
                if !newValue {
                    tabSelected = .home
                    screen = .home
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if isCompact {
            tabView
        } else {
            sidebarView
        }
    }
    
    @ViewBuilder
    private var tabView: some View {
        TabView(selection: $tabSelected) {
            ForEach(AppScreen.allCases) { screen in
                switch screen {
                case .home:
                    HomeView(viewModel: homeViewModel)
                        .tabItem {
                            screen.label
                        }
                case .account:
                    @Bindable var accessViewModel = accessViewModel
                    screen.destination
                        .environment(accessViewModel)
                        .tabItem {
                            screen.label
                        }
                default:
                    screen.destination
                        .tabItem {
                            screen.label
                        }
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
                switch screen {
                case .home:
                    HomeView(viewModel: homeViewModel)
                case .account:
                    screen.destination
                        .environment(accessViewModel)
                default:
                    screen.destination
                }
            } else {
                AppScreen.home.destination
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .modelContainer(.preview)
    }
    .environment(AccessViewModel())
}
