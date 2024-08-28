//
//  CustomFilterModalView+FilterText.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 24/8/24.
//

import SwiftUI

extension CustomFilterModalView {
    
    var beginWithSection: some View {
        Section {
            InputView(title: "filterBy_beginWith_title",
                      placeholder: "filterBy_begins_with_placeholder",
                      text: $viewModel.beginWithSelected,
                      error: nil)
        }
    }
    
    var containsSection: some View {
        Section {
            InputView(title: "filterBy_contains_title",
                      placeholder: "filterBy_contains_placeholder",
                      text: $viewModel.containsSelected,
                      error: nil)
        }
    }
    
    var idSection: some View {
        Section {
            InputView(title: "filterBy_id_title",
                      placeholder: "filterBy_id_placeholder",
                      text: $viewModel.idSelected,
                      error: nil)
        }
    }
}
