//
//  NASAImage.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/28/26.
//

import Foundation

struct NASAImageSearchResponse: Codable {
    let collection: NASAImageCollection
}

struct NASAImageCollection: Codable {
    let items: [NASAImageItem]
}

struct NASAImageItem: Codable, Identifiable {
    let id = UUID()
    let links: [NASAImageLink]?
    let data: [NASAImageData]

    enum CodingKeys: String, CodingKey {
        case links
        case data
    }
}

struct NASAImageLink: Codable {
    let href: String
}

struct NASAImageData: Codable {
    let title: String
    let description: String?
    let date_created: String?
}
