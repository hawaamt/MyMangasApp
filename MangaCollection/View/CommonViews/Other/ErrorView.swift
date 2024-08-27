//
//  ErrorView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 24/8/24.
//

import SwiftUI

struct ErrorView: View {
    var retry: (() -> Void)?
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.icloud.fill")
                .font(.system(size: 100))
                .padding()
            Text("mangas_filtered_by_error")
                .multilineTextAlignment(.center)
                .font(.subheadline)
            Button {
                retry?()
            } label: {
                Text("button_retry")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    ErrorView()
}
