//
//  SkeletonView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import SwiftUI
import Shimmer

struct SkeletonView<Content>: View where Content: View {
    @Binding var isLoading: Bool
    let content: () -> Content
    private let columns = [GridItem(.adaptive(minimum: 100))]

    var body: some View {
        if isLoading {
            LazyVGrid(columns: columns) {
                rectangle
                rectangle
                rectangle
            }
            .shimmering(active: isLoading)
            .frame(maxWidth: .infinity)
            .padding()
        } else {
            content()
        }
    }
    
    private var rectangle: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(.bgGray))
            .frame(height: 150)
    }
}

#Preview {
    SkeletonView(isLoading: .constant(true),
                 content: {
        EmptyView()
    })
}
