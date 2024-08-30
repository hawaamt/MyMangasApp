//
//  ErrorView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 24/8/24.
//

import SwiftUI

struct ErrorView: View {
    enum Size {
        case small
        case normal
    }
    var size: ErrorView.Size = .small
    var retry: (() -> Void)?
    
    var body: some View {
        VStack(spacing: size.verticalPadding) {
            Image(.error)
                .resizable()
                .scaledToFit()
                .frame(height: size.height)
            
            Text("mangas_filtered_by_error")
                .foregroundColor(Color(.black))
                .multilineTextAlignment(.center)
                .font(size.font)
                .fontWeight(.semibold)
            
            Button {
                retry?()
            } label: {
                Text("button_retry")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.white))
        )
    }
}

extension ErrorView.Size {
    
    var height: CGFloat {
        switch self {
        case .small:
            120
        case .normal:
            250
        }
    }
    
    var font: Font {
        switch self {
        case .small:
            .caption
        case .normal:
            .headline
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .small:
            8
        case .normal:
            16
        }
    }
}

#Preview {
    ErrorView()
}
