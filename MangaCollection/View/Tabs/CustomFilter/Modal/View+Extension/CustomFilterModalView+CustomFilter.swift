//
//  CustomFilterModalView+CustomFilter.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 23/8/24.
//

import SwiftUI

extension CustomFilterModalView {
    
    @ViewBuilder
    var customFilter: some View {
        Section {
            InputView(title: "filterBy_add_title_filters",
                      placeholder: "filterBy_title_placeholder",
                      text: $viewModel.model.titleSelected)
        }
        .buttonStyle(.plain)
        
        Section {
            addGenre
            if !viewModel.model.customGenres.isEmpty {
                ForEach(viewModel.model.customGenres) {
                    Text($0.genre)
                        .leadingAlign()
                        .foregroundColor(.text)
                }
                .onDelete(perform: { indexSet in
                    viewModel.deleteGenre(in: indexSet)
                })
            }
        }
        .buttonStyle(.plain)
        
        Section {
            addTheme
            if !viewModel.model.customThemes.isEmpty {
                ForEach(viewModel.model.customThemes) {
                    Text($0.theme)
                        .leadingAlign()
                        .foregroundColor(.text)
                }
                .onDelete(perform: { indexSet in
                    viewModel.deleteTheme(in: indexSet)
                })
            }
        }
        .buttonStyle(.plain)
        
        Section {
            addDemographic
            if !viewModel.model.customDemographics.isEmpty {
                ForEach(viewModel.model.customDemographics) {
                    Text($0.demographic)
                        .leadingAlign()
                        .foregroundColor(.text)
                }
                .onDelete(perform: { indexSet in
                    viewModel.deleteDemographic(in: indexSet)
                })
            }
        }
        .buttonStyle(.plain)
    }
    
    
    
    var addGenre: some View {
        HStack {
            getListPicker(title: "filterBy_add_genre_filters",
                          for: viewModel.model.genres,
                          selected: $viewModel.model.customGenreSelected)
            .padding(.trailing)
            Button {
                viewModel.addGenreSelected()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .disabled(viewModel.isAddGenreButtonDisabled)
            Spacer()
        }
    }
    
    var addTheme: some View {
        HStack {
            getListPicker(title: "filterBy_add_theme_filters",
                          for: viewModel.model.themes,
                          selected: $viewModel.model.customThemeSelected)
                .padding(.trailing)
            Button {
                viewModel.addThemeSelected()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .disabled(viewModel.isAddThemeButtonDisabled)
            Spacer()
        }
    }
    
    var addDemographic: some View {
        HStack {
            getListPicker(title: "filterBy_add_demographic_filters",
                          for: viewModel.model.demographics,
                          selected: $viewModel.model.customDemographicSelected)
                .padding(.trailing)
            Button {
                viewModel.addDemographicSelected()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .disabled(viewModel.isAddDemographicButtonDisabled)
            Spacer()
        }
    }
}
