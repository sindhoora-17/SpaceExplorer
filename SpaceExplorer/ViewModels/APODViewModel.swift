//
//  APODViewModel.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation
import Combine

@MainActor
class APODViewModel: ObservableObject {
    
    @Published var apod: APOD?
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func loadAPOD() async {
        
        isLoading = true
        errorMessage = ""
        
        do {
            apod = try await NASAServices.shared.fetchAPOD()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
