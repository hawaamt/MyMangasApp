//
//  MangaInfoView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import SwiftUI

struct MangaInfoView: View {
    let scoreInfo: String
    let volumesInfo: String
    let year: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(Color(.gold))
                    .frame(width: 20)
                Text(scoreInfo)
                    .leadingAlign()
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            HStack {
                Image(systemName: "list.bullet")
                    .foregroundColor(.gray)
                    .frame(width: 20)
                Text(volumesInfo)
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
    }
}

#Preview {
    MangaInfoView(scoreInfo: "8.5 / 10", volumesInfo: "125", year: "1998")
}
