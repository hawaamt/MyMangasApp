//
//  HomeView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                    Section {
                        top10
                    } header: {
                        header(title: "home_best_title")
                    }
                    
                    Section {
                        authores
                    } header: {
                        header(title: "home_authors")
                    }
                    
                    Section {
                        demographic
                    } header: {
                        header(title: "home_demographic")
                    }
                    
                    Section {
                        genres
                    } header: {
                        header(title: "home_genres")
                    }
                    
                    Section {
                        themes
                    } header: {
                        header(title: "home_themes")
                    }
                }
            }
            .refreshable {
                Task {
                    await viewModel.loadData()
                }
            }
            .navigationDestination(for: Manga.self) {
                MangaDetailsView(viewModel: MangaDetailsViewModel(manga: $0))
            }
            .navigationDestination(for: Author.self) {
                MangasFilteredByFactory(mangasBy: .author($0)).makeView()
            }
            .navigationDestination(for: Demographic.self) {
                MangasFilteredByFactory(mangasBy: .demographic($0)).makeView()
            }
            .navigationDestination(for: Genre.self) {
                MangasFilteredByFactory(mangasBy: .genre($0)).makeView()
            }
            .navigationDestination(for: Theme.self) {
                MangasFilteredByFactory(mangasBy: .theme($0)).makeView()
            }
            .navigationTitle("home_navigationTitle")
        }
    }
}

extension HomeView {
    
    var top10: some View {
        VStack {
            switch viewModel.loadingMangasState {
            case .idle, .loading:
                HomeMangaCard.placeholder
            case .loaded:
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.bestMangas) { manga in
                            NavigationLink(value: manga) {
                                HomeMangaCard(manga: manga) {}
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.leading)
                }
            case .empty:
                NoDataView()
            case .error:
                ErrorView {
                    Task {
                        await viewModel.loadBestMangas()
                    }
                }
            }
        }
    }
    
    var authores: some View {
        VStack {
            switch viewModel.loadingAuthorsState {
            case .idle, .loading:
                AuthorMangaCard.placeholder
            case .loaded:
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.authors) { author in
                            NavigationLink(value: author) {
                                AuthorMangaCard(author: author)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.leading)
                }
            case .empty:
                NoDataView()
            case .error:
                ErrorView {
                    Task {
                        await viewModel.loadAuthors()
                    }
                }
            }
        }
    }
    
    var demographic: some View {
        VStack {
            switch viewModel.loadingDemographicsState {
            case .idle, .loading:
                CustomCard.placeholder
            case .loaded:
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.demographics) { demographic in
                            NavigationLink(value: demographic) {
                                CustomCard(image: demographic.image,
                                           title: demographic.demographic)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 2)
                    .padding(.leading)
                }
            case .empty:
                NoDataView()
            case .error:
                ErrorView {
                    Task {
                        await viewModel.loadDemographics()
                    }
                }
            }
        }
    }
    
    var genres: some View {
        VStack {
            switch viewModel.loadingGenresState {
            case .idle, .loading:
                CustomCard.placeholder
            case .loaded:
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.genres) { genre in
                            NavigationLink(value: genre) {
                                CustomCard(image: genre.image,
                                           title: genre.genre)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 2)
                    .padding(.leading)
                }
            case .empty:
                NoDataView()
            case .error:
                ErrorView {
                    Task {
                        await viewModel.loadGenres()
                    }
                }
            }
        }
    }
    
    var themes: some View {
        VStack {
            switch viewModel.loadingThemesState {
            case .idle, .loading:
                CustomCard.placeholder
            case .loaded:
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.themes) { theme in
                            NavigationLink(value: theme) {
                                CustomCard(image: theme.image,
                                           title: theme.theme)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 2)
                    .padding(.leading)
                }
            case .empty:
                NoDataView()
            case .error:
                ErrorView {
                    Task {
                        await viewModel.loadThemes()
                    }
                }
            }
        }
    }
    
    func header(title: String) -> some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(.title3)
                .fontWeight(.bold)
                .leadingAlign()
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

#Preview {
    let viewModel = HomeViewModel(interactor: MangaInteractorGenericMock())
    return HomeView(viewModel: viewModel)
        .modelContainer(.preview)
}
