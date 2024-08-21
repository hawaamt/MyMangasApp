//
//  AsyncImageView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 11/7/24.
//

import SwiftUI

struct AsyncImageView: View {
    
    let url: String?
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color(.bgGray)
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                ZStack {
                    Color(.bgGray)
                    Image(systemName: "photo")
                        .font(.system(size: 30))
                }
            @unknown default:
                EmptyView()
            }
        }
    }
}
