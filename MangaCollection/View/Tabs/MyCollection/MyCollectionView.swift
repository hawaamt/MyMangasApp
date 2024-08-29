//
//  MyCollectionView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 3/7/24.
//

import SwiftUI
import SwiftData

struct MyCollectionView: View {
    @Environment(\.modelContext) private var context
    
    @State var viewModel: MyCollectionViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.collection.isEmpty {
                    Spacer()
                    NoDataView()
                    Spacer()
                } else {
                    content
                }
            }
            .task {
                viewModel.updateCollection(in: context)
            }
            .navigationDestination(for: CollectionItem.self) { collection in
                MangaDetailsView(viewModel: MangaDetailsViewModel(manga: collection.manga))
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        let columns = [GridItem(.flexible()),
                       GridItem(.flexible())]
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.collection) { item in
                    NavigationLink(value: item) {
                        VStack {
                            ZStack {
                                AsyncImageView(url: item.manga.mainPicture,
                                               height: 100)
                                .frame(width: 100)
                                .clipShape(.buttonBorder)
                                if item.completeCollection {
                                    VStack {
                                        Spacer()
                                        Text("my_collection_complete")
                                            .font(.caption2)
                                            .padding(5)
                                            .background(Color(.success))
                                            .clipShape(.buttonBorder)
                                            .padding(.bottom, 3)
                                    }
                                }
                            }.frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading) {
                                Text(item.manga.title)
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                                Text("my_collection_reading \(item.volumeReadingDescription)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(Color(.textLight))
                                    .font(.caption)
                                Text("my_collection_volumes \(item.volumesOwned.count)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(Color(.textLight))
                                    .font(.caption)
                            }
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .foregroundStyle(Color(.text))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(.buttonBorder)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        MyCollectionFactory
            .makeView()
            .modelContainer(.preview)
    }
}
