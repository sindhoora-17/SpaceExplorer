//
//  AsteroidViewModel.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/31/26.
//

import Foundation
import Combine

@MainActor
class AsteroidViewModel: ObservableObject {
    
    @Published var selectedDate = Date()
    @Published var asteroids: [Asteroid] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    var hazardousCount: Int {
        asteroids.filter { $0.isPotentiallyHazardous }.count
    }
    
    func loadAsteroids() async {
        isLoading = true
        errorMessage = ""
        
        do {
            asteroids = try await NASAServices.shared.fetchAsteroids(for: selectedDate)
        } catch {
            errorMessage = "Unable to load asteroid data."
        }
        
        isLoading = false
    }
}
