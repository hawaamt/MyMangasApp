//
//  MyAccountView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 28/8/24.
//

import SwiftUI

struct MyAccountView: View {
    @Environment(AccessViewModel.self) private var viewModel
    
    var body: some View {
        VStack {
            Spacer()
            Image(.launchscreen)
                .resizable()
                .scaledToFit()
            Spacer()
            Button {
                viewModel.logout()
            } label: {
                Text("access_logout_submit")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .frame(height: 40)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    MyAccountView()
        .environment(AccessViewModel())
}
