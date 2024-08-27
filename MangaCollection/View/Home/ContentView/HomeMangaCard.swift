//
//  HomeMangaCard.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import SwiftUI
import SwiftData

struct HomeMangaCard: View {
    @Environment(\.modelContext) private var context

    private let cardWidth: CGFloat = 160
    private let imageCardHeight: CGFloat = 200
    private let cornerRadius: CGFloat = 10
    private let markerPaddingExternal: CGFloat = 16
    private let markerPaddingInternal: CGFloat = 12
    
    @State var isMangaInMyCollection: Bool = false
    
    let manga: Manga
    var action: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImageView(url: manga.mainPicture,
                               height: imageCardHeight)
                    .frame(width: cardWidth)
                
                VStack(alignment: .leading) {
                    
                    Image(systemName: "bookmark.fill")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.leading, markerPaddingExternal)
                        .padding(.top, markerPaddingExternal)
                        .padding(.trailing, markerPaddingInternal)
                        .padding(.bottom, markerPaddingInternal)
                        .background(.accent)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: cornerRadius,
                                topTrailingRadius: 0
                            )
                        )
                        .opacity(isMangaInMyCollection ? 1 : 0)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
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
        .onAppear {
            isInMyCollection()
        }
    }
    
    private func isInMyCollection() {
        let predicate = #Predicate<CollectionItem> { item in
            item.manga.id == manga.id
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        do {
            let data = try context.fetch(descriptor)
            isMangaInMyCollection = !data.isEmpty
        } catch {
            isMangaInMyCollection = false
        }
    }
}

// MARK: - Placeholder
extension HomeMangaCard {
    @ViewBuilder
    static var placeholder: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0...5, id: \.self) { _ in
                    HomeMangaCard(manga: Manga.placeholder, action: {})
                }
            }
            .padding(.leading)
        }
        .redacted(reason: .placeholder)
        .shimmer()
    }
}

#Preview {
    HomeMangaCard(manga: Manga.manga3, action: {})
        .modelContainer(.preview)
}
