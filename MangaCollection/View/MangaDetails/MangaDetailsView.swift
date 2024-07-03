//
//  MangaDetails.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 7/6/24.
//

import SwiftUI

struct MangaDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: MangaDetailsViewModel
        
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                header
                HStack {
                    MangaInfoView(scoreInfo: viewModel.manga.scoreInfo,
                                  volumesInfo: viewModel.manga.volumesInfo,
                                  year: viewModel.manga.year)
                    status
                }
                .padding()
                
                VStack {
                    Text("details_synopsis")
                        .leadingAlign()
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(viewModel.manga.sypnosis ?? "")
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
                .edgesIgnoringSafeArea(.top)
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
}

// MARK: - Content
extension MangaDetailsView {
    
    var header: some View {
        ZStack {
            imageBg
            VStack {
                Spacer()
                VStack {
                    Text(viewModel.manga.title)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .leadingAlign()
                    Text(viewModel.manga.autors)
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
        if let status = viewModel.manga.status {
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
extension MangaDetailsView {
    var imageBg: some View {
        AsyncImage(url: URL(string: viewModel.manga.mainPicture ?? "")) { phase in
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

#Preview("Manga 1") {
    MangaDetailsView(viewModel: MangaDetailsViewModel(manga: Manga.manga1))
}

#Preview("Manga 2") {
    MangaDetailsView(viewModel: MangaDetailsViewModel(manga: Manga.manga2))
}
