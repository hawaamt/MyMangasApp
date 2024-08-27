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
                    MangaCellView.placeholder
                        .modelContext(context)
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
                    .refreshable {
                        Task {
                            await viewModel.reloadData()
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listStyle(.plain)
                case .empty:
                    Text("mangas_filtered_by_empty")
                case .error:
                    Text("mangas_filtered_by_error")
                    Button("button_retry") {
                        Task {
                            await viewModel.loadData()
                        }
                    }
                }
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
