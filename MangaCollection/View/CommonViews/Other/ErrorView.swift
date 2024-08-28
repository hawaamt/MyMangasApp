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
            Image(.error)
                .resizable()
                .scaledToFit()
                .padding()
            Text("mangas_filtered_by_error")
                .foregroundColor(Color(.black))
                .multilineTextAlignment(.center)
                .font(.headline)
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
                .fill(Color(.white))
        )
    }
}

#Preview {
    ErrorView()
}
