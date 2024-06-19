//
//  MangasFilteredByView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import SwiftUI

struct MangasFilteredByView: View {
    
    @State var viewModel: MangasFilteredByViewModel
    
    var body: some View {
        VStack {
            SkeletonView(type: .list,
                         isLoading: $viewModel.isLoading) {
                ForEach(viewModel.mangas) { manga in
                    NavigationLink(value: manga) {
                        MangaCellView(manga: manga)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
        .task {
            await viewModel.loadData()
        }
        .navigationDestination(for: Manga.self) {
            MangaDetails(manga: $0)
        }
        .navigationTitle("DETAILS")
    }
}

#Preview {
    let viewModel = MangasFilteredByViewModel(mangaBy: .author(.author1),
                                              interactor: MangaInteractorFilteredByMock())
    return NavigationStack {
        MangasFilteredByView(viewModel: viewModel)
    }
}
