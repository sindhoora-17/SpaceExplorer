////
////  MarsRoverView.swift
////  SpaceExplorer
////
////  Created by Sindhoora on 5/27/26.
////
//
//import Foundation
//import SwiftUI
//
//struct MarsRoverView: View {
//
//    @StateObject private var viewModel = MarsRoverViewModel()
//
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//
//    var body: some View {
//
//        ScrollView {
//
//            if viewModel.isLoading {
//
//                ProgressView()
//                    .padding(.top, 50)
//
//            } else if !viewModel.errorMessage.isEmpty {
//
//                Text(viewModel.errorMessage)
//                    .foregroundStyle(.red)
//
//            } else {
//
//                LazyVGrid(columns: columns, spacing: 16) {
//
//                    ForEach(viewModel.photos) { photo in
//
//                        NavigationLink {
//
//                            RoverDetailView(photo: photo)
//
//                        } label: {
//
//                            VStack(alignment: .leading) {
//
//                                AsyncImage(url: URL(string: photo.imgSrc)) { image in
//
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//
//                                } placeholder: {
//
//                                    ProgressView()
//                                }
//                                .frame(height: 160)
//                                .clipped()
//                                .clipShape(RoundedRectangle(cornerRadius: 16))
//
//                                Text(photo.rover.name)
//                                    .font(.headline)
//
//                                Text(photo.earthDate)
//                                    .font(.caption)
//                                    .foregroundStyle(.secondary)
//                            }
//                        }
//                    }
//                }
//                .padding()
//            }
//        }
//        .navigationTitle("Mars Rover")
//        .task {
//            await viewModel.loadPhotos()
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        MarsRoverView()
//    }
//}
