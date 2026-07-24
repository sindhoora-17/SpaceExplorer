//
//  APODHomeView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation
import SwiftUI

struct APODHomeView: View {
    
    @StateObject private var viewModel = APODViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Astronomy Picture of the Day").font(.title2).fontWeight(.bold)
                
                if viewModel.isLoading {
                    ProgressView().frame(maxWidth: .infinity).padding(.top, 40)
                    
                } else if let apod = viewModel.apod {
                    APODMediaView(apod: apod)
                    Text(apod.title).font(.title3).fontWeight(.semibold)
                    
                    Text(apod.date).font(.subheadline).foregroundStyle(.secondary)
                    
                    Text(apod.explanation).font(.body).lineLimit(5)
                    
                    NavigationLink {
                        APODDetailView(apod: apod)
                    } label: {
                        Text("View Details")
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
                    
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage).foregroundStyle(.red)
                    
                } else {
                    Text("No APOD data available.").foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Space Explorer")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadAPOD()
        }
    }
}

#Preview {
    NavigationStack {
        APODHomeView()
    }
}
