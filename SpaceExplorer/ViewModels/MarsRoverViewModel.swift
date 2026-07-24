////
////  MarsRoverViewModel.swift
////  SpaceExplorer
////
////  Created by Sindhoora on 5/27/26.
////
//
//import Foundation
//import Combine
//
//@MainActor
//class MarsRoverViewModel: ObservableObject {
//
//    @Published var photos: [RoverPhoto] = []
//    @Published var isLoading = false
//    @Published var errorMessage = ""
//
//    func loadPhotos() async {
//
//        isLoading = true
//        errorMessage = ""
//
//        do {
//            photos = try await NASAServices.shared.fetchMarsPhotos()
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//
//        isLoading = false
//    }
//}
