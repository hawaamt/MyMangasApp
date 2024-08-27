//
//  MangaCellView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import SwiftUI
import SwiftData

struct MangaCellView: View {
    @Environment(\.modelContext) private var context
    
    private let imageSize: CGFloat = 120
    private let cardHeight: CGFloat = 200
    private let cornerRadius: CGFloat = 10
    private let markerPaddingExternal: CGFloat = 16
    private let markerPaddingInternal: CGFloat = 12
    
    @State var animateGradient = true
    @State var isMangaInMyCollection = true
    
    let manga: Manga
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    AsyncImageView(url: manga.mainPicture,
                                   height: imageSize)
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(.buttonBorder)
                    
                    if let status = manga.status {
                        Text(status.value)
                            .foregroundStyle(status.textColor)
                            .fontWeight(.bold)
                            .font(.caption)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .fill(status.color)
                            )
                    }
                    
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    VStack {
                        Text(manga.title)
                            .leadingAlign()
                            .font(.title3)
                            .foregroundColor(Color(.text))
                            .fontWeight(.medium)
                        
                        MangaInfoView(scoreInfo: manga.scoreInfo,
                                      volumesInfo: manga.volumesInfo,
                                      year: manga.year)
                        if let background = manga.background {
                            Text(background)
                                .leadingAlign()
                                .font(.body)
                                .foregroundColor(Color(.textLight))
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding()
            
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
        .frame(maxHeight: cardHeight)
        .background(Color(.cardBackground))
        .clipShape(.buttonBorder)
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
extension MangaCellView {
    @ViewBuilder 
    static var placeholder: some View {
        List {
            MangaCellView(manga: Manga.manga1)
            MangaCellView(manga: Manga.manga2)
            MangaCellView(manga: Manga.manga3)
        }
        .listRowInsets(EdgeInsets())
        .listStyle(.plain)
        .redacted(reason: .placeholder)
        .shimmer()
    }
}

#Preview("List") {
    MangaCellView(manga: .manga1)
        .modelContainer(.preview)
}

#Preview("Placeholder") {
    VStack {
        MangaCellView.placeholder
            .modelContainer(.preview)
    }
}
