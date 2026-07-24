//
//  RoverExplorerView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 6/8/26.
//

import Foundation
import SwiftUI

struct RoverExplorerView: View {
    
    let rovers = [("Curiosity", "camera.aperture", "curiosity rover"),("Perseverance", "sparkles", "perseverance rover"),("Opportunity", "circle.grid.cross", "opportunity rover"),("Spirit", "globe.americas", "spirit rover")]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                
                Text("Mars Rover Explorer")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Explore rover-related NASA imagery using rover names and keywords.")
                    .foregroundStyle(.secondary)
                
                ForEach(rovers, id: \.0) { rover in
                    NavigationLink {
                        NASAImageSearchView(initialSearchTerm: rover.2)
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: rover.1)
                                .font(.title2)
                                .frame(width: 44, height: 44)
                                .background(.blue.opacity(0.12))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(rover.0)
                                    .font(.headline)
                                
                                Text("Search NASA images for \(rover.0)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(.black.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .buttonStyle(.plain)
                }
                
                NavigationLink {
                    RoverFiltersView()
                } label: {
                    Text("Open Rover Filters")
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
            }
            .padding()
        }
        .navigationTitle("Mars Rover")
        .navigationBarTitleDisplayMode(.inline)
    }
}
