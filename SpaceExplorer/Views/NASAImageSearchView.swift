//
//  NASAImageSearchView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/28/26.
//

import Foundation
import SwiftUI

struct NASAImageSearchView: View {
    
    let initialSearchTerm: String
    
    @StateObject private var viewModel = NASAImageSearchViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            
            let spacing: CGFloat = 16
            let horizontalPadding: CGFloat = 20
            let cardWidth = (geometry.size.width - (horizontalPadding * 2) - spacing) / 2
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Search results for \"\(initialSearchTerm)\"")
                        .font(.headline)
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, 20)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                        
                    } else if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                            .padding()
                        
                    } else {
                        LazyVGrid(
                            columns: [
                                GridItem(.fixed(cardWidth), spacing: spacing),
                                GridItem(.fixed(cardWidth), spacing: spacing)
                            ],
                            spacing: 22
                        ) {
                            ForEach(viewModel.images) { item in
                                NavigationLink {
                                    NASAImageDetailView(item: item)
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        
                                        AsyncImage(url: URL(string: item.links?.first?.href ?? "")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: cardWidth, height: 135)
                                                .clipped()
                                        } placeholder: {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: cardWidth, height: 135)
                                                .overlay {
                                                    ProgressView()
                                                }
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        
                                        Text(item.data.first?.title ?? "Untitled")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.primary)
                                            .lineLimit(2)
                                            .frame(width: cardWidth, height: 34, alignment: .topLeading)
                                    }
                                    .frame(width: cardWidth, alignment: .leading)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, horizontalPadding)
                        .padding(.bottom, 24)
                    }
                }
            }
        }
        .navigationTitle("Search Results")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.searchText = initialSearchTerm
            await viewModel.searchImages()
        }
    }
}

#Preview {
    NavigationStack {
        NASAImageSearchView(initialSearchTerm: "Mars")
    }
}
