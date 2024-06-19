//
//  HomeMangaCard.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import SwiftUI

struct HomeMangaCard: View {
    private let cardWidth: CGFloat = 160
    private let imageCardHeight: CGFloat = 200
    
    let manga: Manga
    var action: () -> Void
       
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: manga.mainPicture ?? "")) { phase in
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
            .frame(width: cardWidth, height: imageCardHeight)
            .clipShape(.buttonBorder)
            .shadow(radius: 2)
                
            Text(manga.title)
                .font(.footnote)
                .fontWeight(.medium)
        }
        .frame(alignment: .leading)
        .frame(width: cardWidth)
    }
}

#Preview {
    HomeMangaCard(manga: Manga.manga3, action: {})
}
