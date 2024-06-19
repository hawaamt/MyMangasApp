//
//  MangaCellView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import SwiftUI

struct MangaCellView: View {
    
    private let imageSize: CGFloat = 120
    
    let manga: Manga
    
    var body: some View {
        HStack {
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
                            .clipCenter(width: imageSize, height: imageSize)
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
                .frame(width: imageSize, height: imageSize)
                .clipShape(.buttonBorder)
                
                if let status = manga.status {
                    Text(status.value)
                        .foregroundStyle(status.textColor)
                        .fontWeight(.bold)
                        .font(.caption)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
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
        .background(Color.accentColor.opacity(0.05))
        .clipShape(.buttonBorder)
    }
}

#Preview {
    MangaCellView(manga: .manga1)
        .frame(height: 200)
}
