//
//  FavoriteDetailView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/31/26.
//

import Foundation
import SwiftUI

struct FavoriteDetailView: View {
    
    let item: FavoriteItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                
                if let imageURL = item.imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                    }
                }
                
                Text(item.title)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(item.type.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let date = item.date {
                    Text(date)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Text(item.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Favorite Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
