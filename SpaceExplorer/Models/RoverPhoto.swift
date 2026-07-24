////
////  RoverPhoto.swift
////  SpaceExplorer
////
////  Created by Sindhoora on 5/27/26.
////
//
//import Foundation
//
//struct LatestPhotosResponse: Codable {
//    let latestPhotos: [RoverPhoto]
//
//    enum CodingKeys: String, CodingKey {
//        case latestPhotos = "latest_photos"
//    }
//}
//
//struct RoverPhoto: Codable, Identifiable {
//
//    let id: Int
//    let imgSrc: String
//    let earthDate: String
//    let rover: Rover
//    let camera: Camera
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case imgSrc = "img_src"
//        case earthDate = "earth_date"
//        case rover
//        case camera
//    }
//}
//
//struct Rover: Codable {
//    let name: String
//}
//
//struct Camera: Codable {
//    let fullName: String
//
//    enum CodingKeys: String, CodingKey {
//        case fullName = "full_name"
//    }
//}
