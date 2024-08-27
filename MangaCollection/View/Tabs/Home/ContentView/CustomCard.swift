//
//  CustomCard.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 14/6/24.
//

import SwiftUI

struct CustomCard: View {
    private let cardWidth: CGFloat = 160
    private let imageCardHeight: CGFloat = 200
    private let shadow: CGFloat = 2
    
    let image: Image
    let title: String
       
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: cardWidth, height: imageCardHeight)
                .scaledToFill()
                .clipShape(.buttonBorder)
                .shadow(radius: shadow)
            
            Text(title)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(Color(.text))
        }
        .frame(alignment: .center)
        .frame(width: cardWidth)
    }
}

// MARK: - Placeholder
extension CustomCard {
    @ViewBuilder
    static var placeholder: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0...5, id: \.self) { _ in
                    CustomCard(image: Image(.mangaDefaultBackground),
                               title: "Placeholder")
                    .listRowSeparator(.hidden)
                }
            }
            .padding(.leading)
        }
        .redacted(reason: .placeholder)
        .shimmer()
    }
}

#Preview {
    CustomCard(image: Genre.genre5.image, title: Genre.genre5.genre)
}
