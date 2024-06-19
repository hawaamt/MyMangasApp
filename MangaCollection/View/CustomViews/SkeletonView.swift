//
//  SkeletonView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import SwiftUI
import Shimmer

enum SkeletonType {
    case grid
    case list
}

struct SkeletonView<Content>: View where Content: View {
    let type: SkeletonType
    @Binding var isLoading: Bool
    let content: () -> Content
    private let columns = [GridItem(.adaptive(minimum: 100))]
    private let rows = [GridItem(.flexible())]
    var body: some View {
        if isLoading {
            switch type {
            case .grid:
                LazyVGrid(columns: columns) {
                    rectangle
                    rectangle
                    rectangle
                }
                .shimmering(active: isLoading)
                .frame(maxWidth: .infinity)
                .padding()
            case .list:
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.bgGray))
                        
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.bgGray))
                        
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.bgGray))
                }
                .shimmering(active: isLoading)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
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
    SkeletonView(type: .list,
                 isLoading: .constant(true),
                 content: {
        EmptyView()
    })
}
