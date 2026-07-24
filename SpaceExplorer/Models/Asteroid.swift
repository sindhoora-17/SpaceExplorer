//
//  Asteroid.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/31/26.
//

import Foundation

struct AsteroidFeedResponse: Codable {
    let elementCount: Int
    let nearEarthObjects: [String: [Asteroid]]
    
    enum CodingKeys: String, CodingKey {
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

struct Asteroid: Codable, Identifiable {
    let id: String
    let name: String
    let nasaJplURL: String
    let absoluteMagnitude: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardous: Bool
    let closeApproachData: [CloseApproachData]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitude = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardous = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
    }
}

struct EstimatedDiameter: Codable {
    let meters: DiameterRange
}

struct DiameterRange: Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}

struct CloseApproachData: Codable {
    let closeApproachDate: String
    let missDistance: MissDistance
    let relativeVelocity: RelativeVelocity
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case missDistance = "miss_distance"
        case relativeVelocity = "relative_velocity"
    }
}

struct MissDistance: Codable {
    let kilometers: String
}

struct RelativeVelocity: Codable {
    let kilometersPerHour: String
    
    enum CodingKeys: String, CodingKey {
        case kilometersPerHour = "kilometers_per_hour"
    }
}
