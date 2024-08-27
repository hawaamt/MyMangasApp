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
            VStack {
                Text("filterBy_beginWith_title")
                    .foregroundColor(.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                getTextfield(title: "filterBy_begins_with_placeholder",
                             selected: $viewModel.beginWithSelected)
            }
        }
    }
    
    var containsSection: some View {
        Section {
            VStack {
                Text("filterBy_contains_title")
                    .foregroundColor(.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                getTextfield(title: "filterBy_contains_placeholder",
                             selected: $viewModel.containsSelected)
            }
        }
    }
    
    var idSection: some View {
        Section {
            VStack {
                Text("filterBy_id_title")
                    .foregroundColor(.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                getTextfield(title: "filterBy_id_placeholder",
                             selected: $viewModel.idSelected)
            }
        }
    }
}
