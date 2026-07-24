//
//  NASAServices.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation
class NASAServices {
    
    static let shared = NASAServices()
    
    private let apiKey = Secrets.nasaAPIKey
    
    func fetchAPOD() async throws -> APOD {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(APOD.self, from: data)
    }
    
    func fetchNASAImages(searchTerm: String) async throws -> [NASAImageItem] {
        let encodedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchTerm
        let urlString = "https://images-api.nasa.gov/search?q=\(encodedTerm)&media_type=image"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(NASAImageSearchResponse.self, from: data)
        return response.collection.items
    }
    
    //api is deprecated
    //    func fetchMarsPhotos() async throws -> [RoverPhoto] {
    //        
    //        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos?api_key=\(apiKey)"
    //        print(urlString)
    //
    //        guard let url = URL(string: urlString) else {
    //            throw URLError(.badURL)
    //        }
    //
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //
    //        if let httpResponse = response as? HTTPURLResponse {
    //            print("Mars API status code:", httpResponse.statusCode)
    //        }
    //
    //        if let jsonString = String(data: data, encoding: .utf8) {
    //            print("Mars API response:", jsonString)
    //        }
    //
    //        let decoder = JSONDecoder()
    //        let roverResponse = try decoder.decode(LatestPhotosResponse.self, from: data)
    //
    //        return roverResponse.latestPhotos
    //    }
    
    func fetchAsteroids(for date: Date) async throws -> [Asteroid] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        let urlString = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(dateString)&end_date=\(dateString)&api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Asteroid API status code:", httpResponse.statusCode)
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Asteroid API response:", jsonString.prefix(500))
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(AsteroidFeedResponse.self, from: data)
        
        return result.nearEarthObjects[dateString] ?? []
    }
}
