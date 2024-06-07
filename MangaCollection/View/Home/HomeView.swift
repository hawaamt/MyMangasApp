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
            VStack {
                ScrollView {
                    VStack {
                        Text("home_best_title")
                            .font(.headline)
                            .leadingAlign()
                            .padding(.leading)
                        SkeletonView(isLoading: $viewModel.isLoading) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(viewModel.bestMangas) {
                                        HomeMangaCard(manga: $0) {
                                            // TODO: navigate to details
                                        }
                                    }
                                }
                                .padding(.leading)
                            }
                        }
                        .frame(minHeight: 175)
                    }
                    Text("home_best_title")
                        .font(.headline)
                        .leadingAlign()
                        .padding(.leading)
                }
            }
            .task {
                await viewModel.loadBestMangas()
            }
            .navigationTitle("home_navigationTitle")
        }
    }
}

#Preview {
    let viewModel = HomeViewModel(interactor: MangaInteractorMock())
    return HomeView(viewModel: viewModel)
}
