//
//  NoDataView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 24/8/24.
//

import SwiftUI

struct NoDataView: View {
    var body: some View {
        VStack {
            Image(.noData)
                .resizable()
                .scaledToFit()
                .padding()
            Text("mangas_filtered_by_no_data")
                .foregroundColor(Color(.black))
                .multilineTextAlignment(.center)
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.white))
        )
    }
}

#Preview {
    NoDataView()
}
