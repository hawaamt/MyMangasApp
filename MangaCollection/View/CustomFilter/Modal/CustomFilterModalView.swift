//
//  CustomFilterModalView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import SwiftUI

struct CustomFilterModalView: View {
    
    @State var viewModel: CustomFilterModalViewModel
    @Binding var isShowingModal: Bool
    
    var listSectionSpacing: CGFloat = 14
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        filterHeader
                    }
                    
                    switch viewModel.filterBy {
                    case .genre, .theme, .demographic, .author:
                        Section {
                            comboFilterBy
                        }
                    case .beginWith:
                        Section {
                            getTextfield(title: "filterBy_begins_with_placeholder",
                                         selected: $viewModel.beginWithSelected)
                        }
                    case .contains:
                        Section {
                            getTextfield(title: "filterBy_contains_placeholder",
                                         selected: $viewModel.containsSelected)
                        }
                    case .id:
                        Section {
                            getTextfield(title: "filterBy_add_demographic_filters",
                                         selected: $viewModel.idSelected)
                        }
                    case .custom:
                        customFilter
                    default:
                        Spacer()
                    }
                }
                .listSectionSpacing(listSectionSpacing)
                .foregroundColor(Color.accentColor)
                .listStyle(.insetGrouped)
                .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
                
                VStack {
                    Spacer()
                    cleanFilters
                }
            }
            .background(Color(.secondarySystemBackground))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("my_collection_cancel") {
                        isShowingModal.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("my_collection_accept") {
                        isShowingModal.toggle()
                    }
                }
            }
        }
    }
    
    func getListPicker<T: PickerList>(title: String,
                                      for items: [T],
                                      selected: Binding<T?>) -> some View {
        Picker(selection: selected) {
            ForEach(items, id: \.self) {
                Text($0.title)
                    .tag($0 as T?)
            }
        } label: {
            Text(LocalizedStringKey(title))
                .font(.caption)
                .foregroundStyle(.text)
        }
        .pickerStyle(.menu)
    }
    
    func getTextfield(title: String,
                      selected: Binding<String>) -> some View {
        HStack {
            TextField(title, text: selected)
                .submitLabel(.done)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.accent)
        )
    }
}

private extension CustomFilterModalView {
    
    var filterHeader: some View {
        VStack {
            Text("Tipo de filtrado")
                .leadingAlign()
                .foregroundColor(.text)
                .font(.title3)
                .fontWeight(.medium)
            Text("Selecciona el tipo de filtrado que se quiere aplicar. En función del tipo de filtro se permitirán filtrar por diferentes categorías o valores del manga.")
                .leadingAlign()
                .foregroundColor(.gray)
                .font(.body)
            HStack {
                VStack {
                    Picker("", selection: $viewModel.filterBy) {
                        ForEach(FilterBy.allCases, id: \.self) {
                            Text($0.title)
                                .tag($0 as FilterBy?)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .accentColor(.white)
                }
                .padding(.trailing)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.accent)
                )
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var cleanFilters: some View {
        Button {
            viewModel.cleanFilters()
        } label: {
            Text("filterBy_clean_filters")
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .frame(height: 44)
        }
        .padding()
        .buttonStyle(.borderedProminent)
    }
}

// MARK: - Pickers
private extension CustomFilterModalView {
    var comboFilterBy: some View {
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
                case .author:
                    getListPicker(title: "filterBy_add_author_filters",
                                  for: viewModel.authors,
                                  selected: $viewModel.authorSelected)
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

// MARK: - Custom filter
private extension CustomFilterModalView {
    
    @ViewBuilder
    var customFilter: some View {
        Section {
            VStack {
                Text("filterBy_add_title_filters")
                    .foregroundColor(.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("filterBy_title_placeholder", text: $viewModel.idSelected)
                        .submitLabel(.done)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.accent)
                )
            }
        }
        .buttonStyle(.plain)
        
        Section {
            addGenre
            if !viewModel.customGenres.isEmpty {
                ForEach(viewModel.customGenres) {
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
            if !viewModel.customThemes.isEmpty {
                ForEach(viewModel.customThemes) {
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
            if !viewModel.customDemographics.isEmpty {
                ForEach(viewModel.customDemographics) {
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
                          for: viewModel.genres,
                          selected: $viewModel.customGenreSelected)
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
            getListPicker(title: "filterBy_add_theme_filters", for: viewModel.themes, selected: $viewModel.customThemeSelected)
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
            getListPicker(title: "filterBy_add_demographic_filters", for: viewModel.demographics, selected: $viewModel.customDemographicSelected)
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

private extension FilterBy {
    var comboTitle: LocalizedStringKey {
        switch self {
        case .genre: LocalizedStringKey("filterBy_select_genre")
        case .theme: LocalizedStringKey("filterBy_select_theme")
        case .demographic: LocalizedStringKey("filterBy_select_demographic")
        case .author: LocalizedStringKey("filterBy_select_author")
        default: LocalizedStringKey("")
        }
    }
}

#Preview {
    CustomFilterModalView(viewModel: CustomFilterModalViewModel(authors: Author.mockList,
                                                                genres: Genre.mockList,
                                                                themes: Theme.mockList,
                                                                demographics: Demographic.mockList
                                                               ), isShowingModal: .constant(true))
}
