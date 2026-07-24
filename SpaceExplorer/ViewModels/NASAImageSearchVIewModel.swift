//
//  NASAImageSearchVIewModel.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/28/26.
//

import Foundation
import Combine

@MainActor
class NASAImageSearchViewModel: ObservableObject {

    @Published var searchText = "mars"
    @Published var images: [NASAImageItem] = []
    @Published var isLoading = false
    @Published var errorMessage = ""

    func searchImages() async {
        isLoading = true
        errorMessage = ""

        do {
            images = try await NASAServices.shared.fetchNASAImages(searchTerm: searchText)
        } catch {
            errorMessage = "Unable to load NASA images."
        }

        isLoading = false
    }
}
