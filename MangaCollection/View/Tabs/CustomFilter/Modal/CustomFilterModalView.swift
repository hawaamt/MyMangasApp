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
                    filterHeader
                    switch viewModel.model.filterBy {
                    case .genre, .theme, .demographic:
                        comboFilterBy
                    case .author:
                        authorSection
                    case .beginWith:
                        beginWithSection
                    case .contains:
                        containsSection
                    case .id:
                        idSection
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
                        .background(Color.background)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
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
                        viewModel.acceptFilter()
                    }
                    .disabled(viewModel.isAcceptDisabled)
                }
            }
        }
        .toast(toastView: ToastView(text: viewModel.errorToast, type: .error, position: .top, show: $viewModel.showErrorToast),
               show: $viewModel.showErrorToast)
    }
}

// MARK: - Other components
private extension CustomFilterModalView {
    var cleanFilters: some View {
        Button {
            viewModel.cleanFilters()
            isShowingModal.toggle()
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

// MARK: - Picker and textfield
extension CustomFilterModalView {
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
}

private extension FilterByModel {
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
    CustomFilterModalView(
        viewModel: CustomFilterModalViewModel(
            genres: Genre.mockList,
            themes: Theme.mockList,
            demographics: Demographic.mockList,
            filterBy: nil, 
            onAccept: { _ in }
        ),
        isShowingModal: .constant(true)
    )
}
