//
//  HomeMangaCard.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import SwiftUI

struct HomeMangaCard: View {
    private let cardWidth: CGFloat = 130
    private let imageCardHeight: CGFloat = 175
    
    let manga: Manga
    var action: () -> Void
       
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                AsyncImage(url: URL(string: manga.mainPicture ?? "")) { phase in
                    switch phase {
                        case .empty:
                            ZStack {
                                Color(.bgGray)
                                ProgressView()
                            }
                        case .success(let image):
                            VStack {
                                image.resizable()
                                    .frame(width: cardWidth, height: imageCardHeight)
                                    .aspectRatio(contentMode: .fit)
                            }
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
                .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                Text(manga.title)
                    .leadingAlign()
                    .font(.footnote)
                    .fontWeight(.medium)
            }
            .frame(alignment: .leading)
            .frame(width: cardWidth)
        }
        .accentColor(Color(.text))
    }
}

#Preview {
    HomeMangaCard(manga: Manga.manga3, action: {})
}
