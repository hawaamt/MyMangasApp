//
//  MangasFilteredByView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import SwiftUI

struct MangasFilteredByView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: MangasFilteredByViewModel

    var body: some View {
        VStack {
            HStack {
                switch viewModel.state {
                case .idle, .loading:
                    VStack {
                        MangaCellView.placeholder
                    }
                    .padding()
                case .loaded:
                    List {
                        ForEach(viewModel.mangas) { manga in
                            NavigationLink(value: manga) {
                                MangaCellView(manga: manga)
                                    .modelContext(context)
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color(.background))
                            .listRowSeparator(.hidden)
                        }
                        if !viewModel.listIsFull {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .onAppear {
                                    Task {
                                        await viewModel.loadData()
                                    }
                                }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listStyle(.plain)
                case .empty:
                    Text("No hay datos que mostrar")
                case .error:
                    Text("Ha ocurrido un error")
                    Button("Reintentar") {
                        Task {
                            await viewModel.loadData()
                        }
                    }
                }
            }
            .navigationDestination(for: Manga.self) {
                MangaDetailsView(viewModel: MangaDetailsViewModel(manga: $0))
            }
            .navigationTitle(viewModel.mangaBy.title)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .tint(.accentColor)
                }
            }
        }
    }

}

#Preview("Empty") {
    let viewModel = MangasFilteredByViewModel(mangaBy: .author(.author1),
                                              interactor: MangaInteractorFilteredByMock(stateToTest: .empty))
    return NavigationStack {
        MangasFilteredByView(viewModel: viewModel)
            .modelContainer(.preview)
    }
}

#Preview("Loaded") {
    let viewModel = MangasFilteredByViewModel(mangaBy: .author(.author1),
                                              interactor: MangaInteractorFilteredByMock(stateToTest: .loaded))
    return NavigationStack {
        MangasFilteredByView(viewModel: viewModel)
            .modelContainer(.preview)
    }
}

#Preview("Error") {
    let viewModel = MangasFilteredByViewModel(mangaBy: .author(.author1),
                                              interactor: MangaInteractorFilteredByMock(stateToTest: .error))
    return NavigationStack {
        MangasFilteredByView(viewModel: viewModel)
            .modelContainer(.preview)
    }
}
