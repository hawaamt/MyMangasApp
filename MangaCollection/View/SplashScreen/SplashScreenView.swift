//
//  SplashScreenView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 30/8/24.
//

import SwiftUI
import SwiftData

struct SplashScreenView: View {
    @Environment(\.modelContext) private var context
    
    @State var viewModel: SplashScreenViewModel
    
    var body: some View {
        ZStack {
            Image(.launchscreen)
                .resizable()
            ProgressView()
                .progressViewStyle(.circular)
        }
        .task {
            viewModel.syncLocalWithRemote(in: context)
        }
        .ignoresSafeArea()
    }    
}

#Preview {
    SplashScreenView(viewModel: SplashScreenViewModel())
}
