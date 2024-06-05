//
//  ContentView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Datos") {
                Task {
                    print("TASK")
                    let iteractor: MangaInteractor = MangaInteractorImp()
                    do {
                        let response = try await iteractor.getMangaList(with: MangaPagination(page: 1, per: 100))
                        print(response)
                    } catch {
                        print(error)
                    }
                    print("TASK 2 ")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
