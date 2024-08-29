//
//  MyCollectionEditView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 15/7/24.
//

import SwiftUI

struct MyCollectionEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: MyCollectionEditViewModel
    
    @FocusState private var newReadingFocused: Bool
    @FocusState private var newVolumeFocused: Bool

    private let itemsSpacing: CGFloat = 24
    
    var body: some View {
        NavigationStack {
            List {
                isCompleted
                sectionReading
                if !viewModel.isCompleted {
                    sectionVolumesOwned
                }
            }
            .foregroundColor(Color.accentColor)
            .listStyle(.insetGrouped)
            .navigationTitle(viewModel.mangaTitle)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("my_collection_cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("my_collection_accept") {
                        viewModel.saveData()
                        dismiss()
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("my_collection_cancel") {
                        newReadingFocused = false
                        newVolumeFocused = false
                    }
                    
                    Spacer()

                    Button("my_collection_accept") {
                        newReadingFocused = false
                        newVolumeFocused = false
                    }
                 }
            }
            .onChange(of: newVolumeFocused) { _, newValue in
                if newValue {
                    viewModel.error = nil
                }
            }
        }
    }
}

// MARK: - Section Reading
private extension MyCollectionEditView {
    var isCompleted: some View {
        Section {
            Toggle(isOn: $viewModel.isCompleted) {
                Text("my_collection_isCompleted")
                    .leadingAlign()
                    .foregroundColor(.text)
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
    }
    
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
        InputView(title: "my_collection_edit_reading_title",
                  placeholder: "my_collection_edit_reading_placeholder",
                  text: $viewModel.volumeReading,
                  keyboardType: .numberPad)
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
            ForEach(viewModel.volumesOwned, id: \.self) {
                Text("my_collection_volume: \($0)")
                    .leadingAlign()
                    .foregroundColor(.textLight)
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .onDelete(perform: { indexSet in
                self.viewModel.volumesOwned.remove(atOffsets: indexSet)
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
                                      text: $viewModel.newVolume,
                                      onEditingChanged: { editingChanged in
                                if editingChanged {
                                    viewModel.error = nil
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
                            viewModel.addVolume()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    if let error = viewModel.error {
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
}

// MARK: - Preview
#Preview {
    let viewModel = MyCollectionEditViewModel(mangaTitle: Manga.manga1.title,
                                              volumeReading: "1",
                                              volumesOwned: ["1", "2", "3"], isCompleted: false) {_, _, _ in }
    return MyCollectionEditView(viewModel: viewModel)
}
