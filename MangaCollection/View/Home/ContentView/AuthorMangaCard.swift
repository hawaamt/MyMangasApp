//
//  AuthorMangaCard.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 19/6/24.
//

import SwiftUI

struct AuthorMangaCard: View {
    
    let author: Author
    
    var body: some View {
        VStack {
            if let title {
                Text(title)
                    .leadingAlign()
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.text))
            } 
            if let subtitle {
                Text(subtitle)
                    .leadingAlign()
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.textLight))
            }
            Spacer()
        }
        .padding()
        .background(Color.accentColor.opacity(0.2))
        .frame(alignment: .center)
        .clipShape(.buttonBorder)
    }
    
    var title: String? {
        if let firstName = author.firstName,
           !firstName.isEmpty {
            return firstName
        }
        if let lastName = author.lastName {
            return lastName
        }
        return nil
    }
    
    var subtitle: String? {
        if let lastName = author.lastName,
           author.hasFirstName {
            return lastName
        }
        return nil
    }
}

// MARK: - Placeholder
extension AuthorMangaCard {
    @ViewBuilder
    static var placeholder: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0...5, id: \.self) { _ in
                    AuthorMangaCard(author: Author.placeholder)
                }
            }
            .padding(.leading)
        }
        .redacted(reason: .placeholder)
        .shimmer()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AuthorMangaCard(author: .author1)
        .frame(width: 300, height: 100)
}
