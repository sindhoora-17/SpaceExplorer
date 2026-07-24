//
//  WelcomeView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Image("SPACE EXPLORER")
                    .resizable()
                    .scaledToFill()
                
                Spacer()
                
                NavigationLink {
                    MainMenuView()
                } label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [.blue, .cyan],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(Capsule())
                        .shadow(color: .blue.opacity(0.4), radius: 8)
                }
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
    }
}
