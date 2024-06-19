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
                MangaDetails(manga: $0)
            }
            .navigationTitle("home_navigationTitle")
        }
    }
}

extension HomeView {
    
    var top10: some View {
        VStack {
            SkeletonView(isLoading: $viewModel.isLoadingMangas) {
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
            SkeletonView(isLoading: $viewModel.isLoadingAuthors) {
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
            SkeletonView(isLoading: $viewModel.isLoadingDemographics) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.demographics) { demographic in
                            CustomCard(image: demographic.image,
                                       title: demographic.demographic)
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
            SkeletonView(isLoading: $viewModel.isLoadingGenres) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.genres) { genre in
                            CustomCard(image: genre.image,
                                       title: genre.genre)
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
            SkeletonView(isLoading: $viewModel.isLoadingThemes) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.themes) { theme in
                            CustomCard(image: theme.image,
                                       title: theme.theme)
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
    let viewModel = HomeViewModel(interactor: MangaInteractorMock())
    return HomeView(viewModel: viewModel)
}
