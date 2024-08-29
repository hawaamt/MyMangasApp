//
//  MyCollectionEditViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import SwiftUI

@Observable
class MyCollectionEditViewModel {
    
    var mangaTitle: String
    var volumeReading: String
    var volumesOwned: [String]
    var isCompleted: Bool
    var onSave: (String, [String], Bool) -> Void

    var newVolume: String = ""
    var error: String? = nil
    
    init(mangaTitle: String, 
         volumeReading: String,
         volumesOwned: [String],
         isCompleted: Bool,
         onSave: @escaping (String, [String], Bool) -> Void) {
        self.mangaTitle = mangaTitle
        self.volumeReading = volumeReading
        self.volumesOwned = volumesOwned
        self.isCompleted = isCompleted
        self.onSave = onSave
    }
    
    func addVolume() {
        guard !volumesOwned.contains(newVolume) else {
            error = String(localized: "my_collection_edit_add_volume_error")
            return
        }
        if !newVolume.isEmpty {
            volumesOwned.append(newVolume)
            volumesOwned.sort()
        }
    }
    
    func deleteVolume(at offsets: IndexSet) {
        volumesOwned.remove(atOffsets: offsets)
    }
    
    func saveData() {
        onSave(volumeReading, volumesOwned, isCompleted)
    }
}
