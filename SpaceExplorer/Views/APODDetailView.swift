//
//  APODDetailView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation
import SwiftUI

struct APODDetailView: View {
    
    let apod: APOD
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    
    var favoriteItem: FavoriteItem {
        FavoriteItem(
            id: "apod-\(apod.date)",
            title: apod.title,
            description: apod.explanation,
            imageURL: apod.hdurl ?? apod.url,
            date: apod.date,
            type: .apod
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                if apod.media_type == "image" {
                    AsyncImage(url: URL(string: apod.hdurl ?? apod.url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    WebView(urlString: apod.url)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Text(apod.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(apod.date)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Button {
                    if favoritesViewModel.isFavorite(favoriteItem) {
                        favoritesViewModel.removeFavorite(favoriteItem)
                    } else {
                        favoritesViewModel.addFavorite(favoriteItem)
                    }
                } label: {
                    Label(
                        favoritesViewModel.isFavorite(favoriteItem) ? "Remove from Favorites" : "Save to Favorites",
                        systemImage: favoritesViewModel.isFavorite(favoriteItem) ? "star.fill" : "star"
                    )
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                
                Text(apod.explanation)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("APOD")
        .navigationBarTitleDisplayMode(.inline)
    }
}
