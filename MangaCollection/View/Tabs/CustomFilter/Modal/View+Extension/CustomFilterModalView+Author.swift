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
                      text: $viewModel.idSelected,
                      submitLabel: .search,
                      error: nil) {
                viewModel.submitSearchAuthors()
            }
            
            authorList
        }
    }
    
    @ViewBuilder
    var authorList: some View {
        if viewModel.isSearchingAuthors {
            ProgressView()
                .progressViewStyle(.circular)
        } else {
            if !viewModel.authors.isEmpty {
                ForEach(viewModel.authors) { author in
                    Button {
                        viewModel.authorSelected = author
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.text)
                                .opacity(viewModel.authorSelected == author ? 1 : 0)
                            Text(author.fullName)
                                .foregroundStyle(.text)
                        }
                    }
                }
            }
        }
    }
}
