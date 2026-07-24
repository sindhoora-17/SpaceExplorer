//
//  MainMenuView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/28/26.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
    var body: some View {
        List {
            Section("Astronomy") {
                NavigationLink {
                    APODHomeView()
                } label: {
                    Label("APOD", systemImage: "sparkles")
                }
            }
            
            Section("Exploration") {
                NavigationLink {
                    RoverExplorerView()
                } label: {
                    Label("Mars Rover Explorer", systemImage: "camera.aperture")
                }
                
                NavigationLink {
                    SearchImagesView()
                } label: {
                    Label("Search Images", systemImage: "magnifyingglass")
                }
            }
            
            Section("Tracking") {
                NavigationLink {
                    AsteroidTrackerView()
                } label: {
                    Label("Asteroid Tracker", systemImage: "globe.americas")
                }
            }
            
            Section("Personal") {
                NavigationLink {
                    FavoritesView()
                } label: {
                    Label("Favorites / Settings", systemImage: "star")
                }
            }
        }
        .navigationTitle("Space Explorer")
    }
}

#Preview {
    NavigationStack {
        MainMenuView()
    }
}
