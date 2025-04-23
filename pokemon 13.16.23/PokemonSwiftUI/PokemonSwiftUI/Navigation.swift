//
//  Navigation.swift
//  PokemonSwiftUI
//
//  Created by inoue ayumu on 2025/04/21.
//

import SwiftUI

struct Navigation: View {
    let postpoke: Post
    
    var body: some View {
        
        return VStack(spacing: 20) {
            Text(postpoke.name.capitalized)
                .font(.largeTitle)
                .padding()
            if let url = URL(string: postpoke.sprites.frontDefault) {
                AsyncImage(url: url, transaction: Transaction(animation: .default)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
//                .id(index.sprites.frontDefault)
            }
            Text("ID: \(postpoke.id)")
                .font(.headline)
        }
        .navigationTitle(postpoke.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
    #Preview {
        ContentView()
    }
