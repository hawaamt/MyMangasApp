//
//  MangaDetails.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 7/6/24.
//

import SwiftUI

struct MangaDetails: View {
    @Environment(\.dismiss) private var dismiss
    
    let manga: Manga
        
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                header
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color(.gold))
                                .frame(width: 20)
                            Text(score)
                                .leadingAlign()
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        HStack {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.gray)
                                .frame(width: 20)
                            Text(volumes)
                                .leadingAlign()
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                                .frame(width: 20)
                            Text(year)
                                .leadingAlign()
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }

                    status
                }
                .padding()
                
                VStack {
                    Text("details_synopsis")
                        .leadingAlign()
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(manga.sypnosis ?? "")
                        .leadingAlign()
                        .font(.body)
                }
                .padding()
                
                VStack {
                    Text("details_cast")
                        .leadingAlign()
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.accentColor)
            }
        }
    }
}

// MARK: - Content
extension MangaDetails {
    
    var header: some View {
        ZStack {
            imageBg
            VStack {
                Spacer()
                VStack {
                    Text(manga.title)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .leadingAlign()
                    Text(autors)
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .leadingAlign()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [.clear, Color(.black)]), startPoint: .top, endPoint: .bottom)
                )
            }
        }
    }
    
    @ViewBuilder
    var status: some View {
        if let status = manga.status {
            Spacer()
            VStack {
                Text(status.value)
                    .foregroundStyle(status.textColor)
                    .fontWeight(.bold)
                    .font(.caption)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(status.color)
                    )
                Spacer()
            }
        }
    }
}

// MARK: - Components
extension MangaDetails {
    var imageBg: some View {
        AsyncImage(url: URL(string: manga.mainPicture ?? "")) { phase in
            switch phase {
                case .empty:
                    ZStack {
                        Color(.bgGray)
                        ProgressView()
                    }
                    .frame(height: 350)
                case .success(let image):
                    VStack {
                        image
                            .clipCenter(height: 350)
                    }
                case .failure:
                    VStack {
                        Image(.mangaDefaultBackground)
                            .clipCenter(height: 350)
                    }
                @unknown default:
                    EmptyView()
            }
        }
    }
}

// MARK: - Data
extension MangaDetails {
    
    var autors: String {
        manga.authors.map {
            "\(($0.firstName ?? "")) \($0.lastName ?? "")".trailingSpacesTrimmed
        }.joined(separator: " | ")
    }
    
    var score: String {
        guard let score = manga.score else {
            return "- / 10"
        }
        return "\(score) / 10"
    }
    
    var volumes: String {
        guard let volumes = manga.volumes else {
            return "-"
        }
        return "\(volumes) chapters"
    }
    
    var year: String {
        guard let startDate = manga.startDate else { return "-" }
        return startDate.year
    }
}

#Preview("Manga 1") {
    MangaDetails(manga: Manga.manga1)
}

#Preview("Manga 2") {
    MangaDetails(manga: Manga.manga2)
}
