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
            Image(systemName: "circle.slash")
                .font(.system(size: 100))
                .foregroundColor(.accent)
                .padding()
            Text("mangas_filtered_by_no_data")
                .multilineTextAlignment(.center)
                .font(.subheadline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    NoDataView()
}
