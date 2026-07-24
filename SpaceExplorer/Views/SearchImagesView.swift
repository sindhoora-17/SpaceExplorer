//
//  SearchImagesView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/29/26.
//

import Foundation
import SwiftUI

struct SearchImagesView: View {
    
    @State private var searchText = ""
    
    let popularSearches = ["Mars", "Galaxy", "Moon"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            Text("Search Images")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Search for galaxies, planets, nebulas", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.search)
            
            Text("Popular Searches")
                .font(.headline)
            
            HStack {
                ForEach(popularSearches, id: \.self) { term in
                    NavigationLink {
                        NASAImageSearchView(initialSearchTerm: term)
                    } label: {
                        Text(term)
                            .font(.subheadline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.black.opacity(0.08))
                            .clipShape(Capsule())
                    }
                }
            }
            
            NavigationLink {
                NASAImageSearchView(initialSearchTerm: searchText.isEmpty ? "space" : searchText)
            } label: {
                Text("Search")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Search Images")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SearchImagesView()
    }
}
