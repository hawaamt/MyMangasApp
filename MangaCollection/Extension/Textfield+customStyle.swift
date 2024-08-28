//
//  Textfield+customStyle.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import SwiftUI

extension TextField {

    var customStyle: some View {
        HStack {
            self
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.accent)
        )
    }
}

extension SecureField {
    
    var customStyle: some View {
        HStack {
            self
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.accent)
        )
    }
}
