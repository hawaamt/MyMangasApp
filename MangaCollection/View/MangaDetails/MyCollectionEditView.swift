//
//  MyCollectionEditView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 15/7/24.
//

import SwiftUI

struct MyItem: Identifiable {
    let id = UUID()
    var name: String
}

struct MyCollectionEditView: View {
    
    var mangaTitle: String
    @State var volumeReading: String
    @State var volumesOwned: [String]
    @Binding var isEditingMyCollection: Bool
    var onSave: (String, [String]) -> Void
    
    @State var newVolume: String = ""
    @State var error: String?
    
    @FocusState private var newReadingFocused: Bool
    @FocusState private var newVolumeFocused: Bool

    private let itemsSpacing: CGFloat = 24
    
    var body: some View {
        NavigationStack {
            List {
                sectionReading
                sectionVolumesOwned
            }
            .foregroundColor(Color.accentColor)
            .listStyle(.insetGrouped)
            .navigationTitle(mangaTitle)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("my_collection_cancel") {
                        isEditingMyCollection.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("my_collection_accept") {
                        onSave(volumeReading, volumesOwned)
                        isEditingMyCollection.toggle()
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("my_collection_accept") {
                        newReadingFocused = false
                        newVolumeFocused = false
                    }
                 }
            }
            .onChange(of: newVolumeFocused, { _, newValue in
                if newValue {
                    error = nil
                }
            })
        }
    }
}

// MARK: - Section Reading
private extension MyCollectionEditView {
    var sectionReading: some View {
        Section {
            VStack(spacing: itemsSpacing) {
                Text("my_collection_description")
                    .leadingAlign()
                    .foregroundColor(.text)
                    .font(.body)
                    .fontWeight(.medium)
                readingView
            }
        } header: {
            Text("my_collection_edit_reading_title")
                .font(.headline)
                .fontWeight(.bold)
                .leadingAlign()
        }
        .headerProminence(.increased)
    }
    
    var readingView: some View {
        VStack {
            HStack {
                TextField("my_collection_edit_reading_placeholder", text: $volumeReading)
                    .focused($newReadingFocused)
                    .keyboardType(.numberPad)
                    .submitLabel(.done)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.accent)
            )
        }
    }
}

// MARK: - Section Volumes owned
private extension MyCollectionEditView {
    var sectionVolumesOwned: some View {
        Section {
            VStack(spacing: itemsSpacing) {
                Text("my_collection_description")
                    .leadingAlign()
                    .foregroundColor(.text)
                    .font(.body)
                    .fontWeight(.medium)
                
                volumeView
                
                Text("my_collection_volumes_saved")
                    .leadingAlign()
                    .foregroundColor(.text)
                    .font(.body)
                    .fontWeight(.medium)
            }
            ForEach(volumesOwned, id: \.self) {
                Text("my_collection_volume: \($0)")
                    .leadingAlign()
                    .foregroundColor(.textLight)
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .onDelete(perform: { indexSet in
                self.volumesOwned.remove(atOffsets: indexSet)
            })
        } header: {
            Text("my_collection_edit_add_volume_title")
                .font(.headline)
                .fontWeight(.bold)
                .leadingAlign()
        }
        .buttonStyle(.plain)
        .headerProminence(.increased)
    }
    
    var volumeView: some View {
        VStack(spacing: itemsSpacing) {
            HStack(alignment: .top) {
                VStack {
                    HStack {
                        HStack {
                            TextField("my_collection_edit_add_volume_placeholder",
                                      text: $newVolume,
                                      onEditingChanged: { editingChanged in
                                if editingChanged {
                                    error = nil
                                }
                            })
                            .focused($newReadingFocused)
                            .keyboardType(.numberPad)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.accent)
                        )
                        Button {
                            guard !volumesOwned.contains(newVolume) else {
                                error = String(localized: "my_collection_edit_add_volume_error")
                                return
                            }
                            if !newVolume.isEmpty {
                                volumesOwned.append(newVolume)
                                newReadingFocused = false
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    if let error {
                        Text(error)
                            .leadingAlign()
                            .foregroundColor(.error)
                            .font(.callout)
                            .fontWeight(.medium)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        volumesOwned.remove(atOffsets: offsets)
    }
}

// MARK: - Preview
#Preview {
    @State var isEditingMyCollection: Bool = true
    return MyCollectionEditView(mangaTitle: Manga.manga1.title,
                                volumeReading: "1",
                                volumesOwned: ["1", "2", "3"],
                                isEditingMyCollection: $isEditingMyCollection) {_, _ in }
}
