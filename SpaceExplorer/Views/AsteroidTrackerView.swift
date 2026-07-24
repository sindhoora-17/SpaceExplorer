//
//  AsteroidTrackerView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/31/26.
//

import Foundation
import SwiftUI

struct AsteroidTrackerView: View {
    
    @StateObject private var viewModel = AsteroidViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            
            DatePicker(
                "Select Date",
                selection: $viewModel.selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .padding(.horizontal)
            .padding(.top)
            
            Button {
                Task {
                    await viewModel.loadAsteroids()
                }
            } label: {
                Text("Load Asteroids")
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
            .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 40)
                
                Spacer()
                
            } else if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundStyle(.red)
                    .padding()
                
                Spacer()
                
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Near Earth Objects")
                        .font(.headline)
                    
                    Text("Total Asteroids: \(viewModel.asteroids.count)")
                    Text("Potentially Hazardous: \(viewModel.hazardousCount)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.black.opacity(0.06))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
                
                List(viewModel.asteroids) { asteroid in
                    NavigationLink {
                        AsteroidDetailView(asteroid: asteroid)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(asteroid.name)
                                .font(.headline)
                            
                            Text(asteroid.isPotentiallyHazardous ? "Potentially Hazardous" : "Safe")
                                .font(.caption)
                                .foregroundStyle(asteroid.isPotentiallyHazardous ? .red : .green)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Asteroid Tracker")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadAsteroids()
        }
    }
}

#Preview {
    NavigationStack {
        AsteroidTrackerView()
    }
}
