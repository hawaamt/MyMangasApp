//
//  CustomAsyncImageView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 21/8/24.
//

import SwiftUI

struct AsyncImageView: View {
    var url: String?
    var height: CGFloat
    var offsetY: CGFloat = 0
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
                case .empty:
                    ZStack {
                        Color(.bgGray)
                        ProgressView()
                    }
                    .frame(height: height)
                    .offset(y: offsetY)
                case .success(let image):
                    VStack {
                        image
                            .clipCenter(height: height)
                            .offset(y: offsetY)
                    }
                case .failure:
                    ZStack {
                        Color(.bgGray)
                        Image(systemName: "photo")
                            .font(.system(size: 30))
                    }
                    .frame(height: height)
                    .offset(y: offsetY)
                @unknown default:
                    EmptyView()
            }
        }
    }
}

#Preview {
    AsyncImageView(height: 350, offsetY: 0)
}
