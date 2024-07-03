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
                .refreshable {
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
            SkeletonView(type: .grid,
                         isLoading: $viewModel.isLoadingMangas) {
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
            }
        }
    }
    
    var authores: some View {
        VStack {
            SkeletonView(type: .grid,
                         isLoading: $viewModel.isLoadingAuthors) {
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
            }
        }
    }
    
    var demographic: some View {
        VStack {
            SkeletonView(type: .grid,
                         isLoading: $viewModel.isLoadingDemographics) {
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
            }
        }
    }
    
    var genres: some View {
        VStack {
            SkeletonView(type: .grid,
                         isLoading: $viewModel.isLoadingGenres) {
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
            }
        }
    }
    
    var themes: some View {
        VStack {
            SkeletonView(type: .grid,
                         isLoading: $viewModel.isLoadingThemes) {
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
