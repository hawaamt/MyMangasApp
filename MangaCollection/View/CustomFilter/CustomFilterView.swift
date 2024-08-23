//
//  CustomFilterView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import SwiftUI

struct CustomFilterView: View {
    
    @State var viewModel: CustomFilterViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Custom filter view")
            }
            .navigationTitle("Custom filter")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.isShowingModal.toggle()
                    } label: {
                        viewModel.isFiltering ?
                        Image(systemName: "line.3.horizontal.decrease.circle.fill") :
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .tint(.accentColor)
                }
            }
            .sheet(isPresented: $viewModel.isShowingModal) {
                CustomFilterModalView(viewModel: CustomFilterModalViewModel(authors: viewModel.authors,
                                                                            genres: viewModel.genres,
                                                                            themes: viewModel.themes,
                                                                            demographics: viewModel.demographics), isShowingModal: $viewModel.isShowingModal)
            }
        }
    }
}

#Preview {
    let viewModel = CustomFilterViewModel(interactorGeneric: MangaInteractorGenericMock(),
                                          interactorFilter: MangaInteractorFilteredByMock(stateToTest: .loaded))
    return CustomFilterView(viewModel: viewModel)
        .modelContainer(.preview)
}
