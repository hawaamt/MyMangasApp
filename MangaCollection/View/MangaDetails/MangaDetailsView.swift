//
//  MangaDetails.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 7/6/24.
//

import SwiftUI

struct MangaDetailsView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: MangaDetailsViewModel
        
    var body: some View {
        ScrollView(showsIndicators: false) {
            header
            content
        }
        .onAppear {
            viewModel.getLocalCollection(in: context)
        }
        .listRowInsets(.none)
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
                .disabled(viewModel.isEditing)
            }
        }
        .toast(toastView: ToastView(text: viewModel.errorToast, type: .error, position: .bottom, show: $viewModel.showErrorToast),
               show: $viewModel.showErrorToast)
        .sheet(isPresented: $viewModel.isEditingMyCollection) {
            let viewModel = MyCollectionEditViewModel(
                mangaTitle: viewModel.manga.title,
                volumeReading: viewModel.myMangaCollection?.volumeReadingString ?? "",
                volumesOwned: viewModel.myMangaCollection?.volumesOwned.map({ "\($0)" }) ?? [],
                isCompleted: viewModel.myMangaCollection?.completeCollection ?? false,
                onSave: viewModel.saveEditing
            )
            return MyCollectionEditView(viewModel: viewModel)
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
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [.clear, Color(.black)]), startPoint: .top, endPoint: .bottom)
                )
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            mangaInfo
            mangaInMyCollectionInfo
            synopsis
            authors
        }
    }
}

// MARK: - Content views
extension MangaDetailsView {
    var mangaInfo: some View {
        HStack {
            MangaInfoView(scoreInfo: viewModel.manga.scoreInfo,
                          volumesInfo: viewModel.manga.volumesInfo,
                          year: viewModel.manga.year)
            status
        }
        .padding()
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
    
    var mangaInMyCollectionInfo: some View {
        ZStack {
            if let myManga = viewModel.myMangaCollection {
                myCollection(for: myManga)
            } else {
                HStack {
                    Button("details_add_collection") {
                        Task { @MainActor in
                            viewModel.addToMyCollection(in: context)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if viewModel.isEditing {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }
    
    var synopsis: some View {
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
    }
    
    var authors: some View {
        VStack {
            Text("details_cast")
                .leadingAlign()
                .font(.title3)
                .fontWeight(.bold)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.manga.authors) { author in
                        NavigationLink(value: author) {
                            AuthorMangaCard(author: author)
                                .modelContext(context)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.leading)
            }
        }
    }
}

// MARK: - My collection view
extension MangaDetailsView {
    func myCollection(for manga: CollectionItem) -> some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("details_volume_saved")
                    .leadingAlign()
                    .font(.body)
                    .fontWeight(.bold)
                Text("details_volume_reading \(manga.volumeReadingDescription)")
                    .leadingAlign()
                    .font(.callout)
                    .fontWeight(.medium)
                if manga.completeCollection {
                    Text("my_collection_complete")
                        .font(.caption2)
                        .padding(5)
                        .background(Color(.success))
                        .clipShape(.buttonBorder)
                        .padding(.bottom, 3)
                } else {
                    Text("details_volumes_acquired \(manga.volumesOwnedDescription)")
                        .leadingAlign()
                        .font(.callout)
                        .fontWeight(.medium)
                }
                Button("details_remove_collection") {
                    Task { @MainActor in
                        viewModel.deleteMyCollectionManga(in: context)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            VStack {
                Button {
                    viewModel.isEditingMyCollection.toggle()
                } label: {
                    Image(systemName: "square.and.pencil.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
    }
}

// MARK: - Aux
extension MangaDetailsView {
    var imageBg: some View {
        GeometryReader { reader in
            
            let offset = reader.frame(in: .global).minY
            let height = 350 + (offset > 0 ? offset : 0)
            let offsetY = offset > 0 ? -offset : 0
            AsyncImageView(url: viewModel.manga.mainPicture,
                           height: height,
                           offsetY: offsetY)
        }
        .frame(minHeight: 350)
    }
}

#Preview("Manga 1") {
    NavigationStack {
        MangaDetailsView(viewModel: MangaDetailsViewModel(manga: Manga.manga1))
            .modelContainer(.preview)
    }
}

#Preview("Manga 2") {
    NavigationStack {
        MangaDetailsView(viewModel: MangaDetailsViewModel(manga: Manga.manga2))
            .modelContainer(.preview)
    }
}
