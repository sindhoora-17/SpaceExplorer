//
//  APOD.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation

struct APOD: Codable {
    let title: String
    let explanation: String
    let url: String
    let hdurl: String?
    let date: String
    let media_type: String
}
