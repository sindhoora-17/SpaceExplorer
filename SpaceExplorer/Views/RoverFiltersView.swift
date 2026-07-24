//
//  RoverFiltersView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 6/8/26.
//

import Foundation
import SwiftUI

struct RoverFiltersView: View {
    
    @State private var selectedRover = "Curiosity"
    @State private var keyword = ""
    
    let rovers = ["Curiosity", "Perseverance", "Opportunity", "Spirit"]
    
    var searchTerm: String {
        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedKeyword.isEmpty {
            return "\(selectedRover) rover"
        } else {
            return "\(selectedRover) rover \(trimmedKeyword)"
        }
    }
    
    var body: some View {
        Form {
            Section("Rover") {
                Picker("Select Rover", selection: $selectedRover) {
                    ForEach(rovers, id: \.self) { rover in
                        Text(rover)
                    }
                }
            }
            
            Section("Keyword") {
                TextField("Example: rocks, wheels, panorama", text: $keyword)
            }
            
            Section {
                NavigationLink {
                    NASAImageSearchView(initialSearchTerm: searchTerm)
                } label: {
                    Text("Apply Filters")
                        .fontWeight(.semibold)
                }
            }
        }
        .navigationTitle("Rover Filters")
    }
}
