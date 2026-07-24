//
//  FavoriteItem.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/29/26.
//

import Foundation

struct FavoriteItem: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let description: String
    let imageURL: String?
    let date: String?
    let type: FavoriteType
}

enum FavoriteType: String, Codable {
    case apod = "APOD"
    case nasaImage = "NASA Image"
    case marsRover = "Mars Rover"
    case asteroid = "Asteroid"
}
