//
//  CustomFilterModalView+Author.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 24/8/24.
//

import SwiftUI

extension CustomFilterModalView {
    @ViewBuilder
    var authorSection: some View {
        Section {
            InputView(title: "filterBy_author_title",
                      placeholder: "filterBy_author_placeholder",
                      text: $viewModel.model.idSelected,
                      submitLabel: .search,
                      error: nil) {
                viewModel.submitSearchAuthors()
            }
            
            authorList
        }
    }
    
    @ViewBuilder
    var authorList: some View {
        if viewModel.model.isSearchingAuthors {
            ProgressView()
                .progressViewStyle(.circular)
        } else {
            if !viewModel.model.authors.isEmpty {
                ForEach(viewModel.model.authors) { author in
                    Button {
                        viewModel.model.authorSelected = author
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.text)
                                .opacity(viewModel.model.authorSelected == author ? 1 : 0)
                            Text(author.fullName)
                                .foregroundStyle(.text)
                        }
                    }
                }
            }
        }
    }
}
