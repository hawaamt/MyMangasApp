//
//  CustomFilterView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import SwiftUI

struct CustomFilterView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: CustomFilterViewModel
    
    var body: some View {
        NavigationStack {
            HStack {
                switch viewModel.state {
                case .idle, .loading:
                    MangaCellView.placeholder
                case .loaded:
                    content
                case .empty:
                    NoDataView()
                case .error:
                    ErrorView {
                        Task {
                            await viewModel.loadData()
                        }
                    }
                }
            }
            .navigationTitle("custom_filter_title")
            .navigationDestination(for: Manga.self) {
                MangaDetailsView(viewModel: MangaDetailsViewModel(manga: $0))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isShowingModal.toggle()
                    } label: {
                        viewModel.isFiltering ?
                        Image(systemName: "line.3.horizontal.decrease.circle.fill") :
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .tint(.accentColor)
                }
            }
            .sheet(isPresented: $viewModel.isShowingModal) {
                CustomFilterModalView(
                    viewModel: CustomFilterModalViewModel(
                        genres: viewModel.genres,
                        themes: viewModel.themes,
                        demographics: viewModel.demographics,
                        filterBy: viewModel.filterBy,
                        onAccept: { viewModel.onAcceptFilter($0) }
                    ),
                    isShowingModal: $viewModel.isShowingModal
                )
            }
        }
    }
}

private extension CustomFilterView {
    var content: some View {
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
    }
}

#Preview {
    let viewModel = CustomFilterViewModel(interactorGeneric: MangaInteractorGenericMock(),
                                          interactorFilter: MangaInteractorFilteredByMock(stateToTest: .loaded))
    return CustomFilterView(viewModel: viewModel)
        .modelContainer(.preview)
}
