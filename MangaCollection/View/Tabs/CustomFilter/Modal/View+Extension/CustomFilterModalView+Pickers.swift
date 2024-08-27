//
//  CustomFilterModalView+Pickers.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 23/8/24.
//

import SwiftUI

extension CustomFilterModalView {
    var comboFilterBy: some View {
        Section {
            HStack {
                VStack {
                    switch viewModel.filterBy {
                    case .genre:
                        getListPicker(title: "filterBy_add_genre_filters",
                                      for: viewModel.genres,
                                      selected: $viewModel.genreSelected)
                    case .theme:
                        getListPicker(title: "filterBy_add_theme_filters",
                                      for: viewModel.themes,
                                      selected: $viewModel.themeSelected)
                    case .demographic:
                        getListPicker(title: "filterBy_add_demographic_filters",
                                      for: viewModel.demographics,
                                      selected: $viewModel.demographicSelected)
                    default: EmptyView()
                    }
                }
                .padding(.trailing)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                )
                Spacer()
            }
        }
    }
}
