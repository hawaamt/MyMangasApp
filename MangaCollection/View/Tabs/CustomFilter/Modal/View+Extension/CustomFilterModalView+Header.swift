//
//  CustomFilterModalView+Header.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 30/8/24.
//

import SwiftUI

extension CustomFilterModalView {
    
    var filterHeader: some View {
        Section {
            VStack {
                Text("filterBy_title")
                    .leadingAlign()
                    .foregroundColor(.text)
                    .font(.title3)
                    .fontWeight(.medium)
                Text("filterBy_description")
                    .leadingAlign()
                    .foregroundColor(.gray)
                    .font(.callout)
                    .padding(.bottom)
                HStack {
                    VStack {
                        Picker("", selection: $viewModel.model.filterBy) {
                            ForEach(FilterByModel.allCases, id: \.self) {
                                Text($0.title)
                                    .tag($0 as FilterByModel?)
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
    }
}
