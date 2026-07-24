//
//  FavoritesView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/29/26.
//

import Foundation
import SwiftUI

struct FavoritesView: View {

    @StateObject private var viewModel = FavoritesViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        List {
            Section("Saved Items") {
                if viewModel.favorites.isEmpty {
                    Text("No favorites saved yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(viewModel.favorites) { item in
                        NavigationLink {
                            FavoriteDetailView(item: item)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.title)
                                    .font(.headline)

                                Text(item.type.rawValue)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                Text(item.description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewModel.removeFavorite(viewModel.favorites[index])
                        }
                    }
                }
            }

            Section("Settings") {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }

            Section("About") {
                Text("Space Explorer")
                Text("A NASA data exploration app built with SwiftUI.")
                    .foregroundStyle(.secondary)

                Text("Powered by NASA Open APIs")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Favorites & Settings")
    }
}
