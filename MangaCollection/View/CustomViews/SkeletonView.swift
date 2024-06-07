//
//  SkeletonView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import SwiftUI

struct SkeletonView<Content>: View where Content: View {
    @Binding var isLoading: Bool
    let content: () -> Content

    var body: some View {
        if isLoading {
            VStack(alignment: .center) {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.bgGray))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        } else {
            content()
        }
    }
}

#Preview {
    SkeletonView(isLoading: .constant(true),
                 content: {
        EmptyView()
    })
}
