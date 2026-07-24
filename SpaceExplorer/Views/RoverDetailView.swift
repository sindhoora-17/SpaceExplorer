////
////  RoverDetailView.swift
////  SpaceExplorer
////
////  Created by Sindhoora on 5/27/26.
////
//
//import Foundation
//import SwiftUI
//
//struct RoverDetailView: View {
//
//    let photo: RoverPhoto
//
//    var body: some View {
//
//        ScrollView {
//
//            VStack(alignment: .leading, spacing: 20) {
//
//                AsyncImage(url: URL(string: photo.imgSrc)) { image in
//
//                    image
//                        .resizable()
//                        .scaledToFit()
//
//                } placeholder: {
//
//                    ProgressView()
//                }
//
//                Text(photo.rover.name)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//
//                Text(photo.camera.fullName)
//                    .font(.headline)
//
//                Text("Captured on \(photo.earthDate)")
//                    .foregroundStyle(.secondary)
//            }
//            .padding()
//        }
//        .navigationTitle("Rover Photo")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
