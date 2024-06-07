//
//  Text+alignment.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import SwiftUI

struct TextAlignmentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension Text {
    func leadingAlign() -> some View {
        self.modifier(TextAlignmentModifier())
    }
}
