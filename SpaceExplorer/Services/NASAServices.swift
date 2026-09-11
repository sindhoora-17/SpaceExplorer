//
//  NASAServices.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation

final class NASAServices {
    static let shared = NASAServices()

    private let apiKey = Secrets.nasaAPIKey
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchAPOD() async throws -> APOD {
        var components = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        let data = try await fetchData(from: components)
        return try decoder.decode(APOD.self, from: data)
    }

    func fetchNASAImages(searchTerm: String) async throws -> [NASAImageItem] {
        var components = URLComponents(string: "https://images-api.nasa.gov/search")!
        components.queryItems = [
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "media_type", value: "image")
        ]

        let data = try await fetchData(from: components)
        let response = try decoder.decode(NASAImageSearchResponse.self, from: data)
        return response.collection.items
    }

    func fetchAsteroids(for date: Date) async throws -> [Asteroid] {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"

        let dateString = formatter.string(from: date)
        var components = URLComponents(string: "https://api.nasa.gov/neo/rest/v1/feed")!
        components.queryItems = [
            URLQueryItem(name: "start_date", value: dateString),
            URLQueryItem(name: "end_date", value: dateString),
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        let data = try await fetchData(from: components)
        let result = try decoder.decode(AsteroidFeedResponse.self, from: data)
        return result.nearEarthObjects[dateString] ?? []
    }

    private func fetchData(from components: URLComponents) async throws -> Data {
        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}
