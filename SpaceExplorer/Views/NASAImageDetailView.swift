//
//  NASAImageDetailView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/29/26.
//

import Foundation
import SwiftUI

struct NASAImageDetailView: View {
    
    let item: NASAImageItem
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    
    var favoriteItem: FavoriteItem {
        FavoriteItem(
            id: item.links?.first?.href ?? UUID().uuidString,
            title: item.data.first?.title ?? "Untitled",
            description: item.data.first?.description ?? "No description available.",
            imageURL: item.links?.first?.href,
            date: item.data.first?.date_created,
            type: .nasaImage
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                
                AsyncImage(url: URL(string: item.links?.first?.href ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.top, 40)
                }
                
                Text(item.data.first?.title ?? "Untitled")
                    .font(.title2)
                    .fontWeight(.bold)
                
                if let date = item.data.first?.date_created {
                    Text(date)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
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
                
                Text(item.data.first?.description ?? "No description available.")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Image Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
