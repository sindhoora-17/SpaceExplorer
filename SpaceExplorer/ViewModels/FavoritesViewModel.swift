//
//  FavoritesViewModel.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/29/26.
//

import Foundation
import Combine

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoriteItem] = []
    private let favoritesKey = "savedFavorites"
    init() {
        loadFavorites()
    }
    
    func addFavorite(_ item: FavoriteItem) {
        if !favorites.contains(where: { $0.id == item.id }) {
            favorites.append(item)
            saveFavorites()
        }
    }
    
    func removeFavorite(_ item: FavoriteItem) {
        favorites.removeAll { $0.id == item.id }
        saveFavorites()
    }
    
    func isFavorite(_ item: FavoriteItem) -> Bool {
        favorites.contains { $0.id == item.id }
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
    
    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let decodedFavorites = try? JSONDecoder().decode([FavoriteItem].self, from: data) else {
            favorites = []
            return
        }
        
        favorites = decodedFavorites
    }
}
