//
//  APODPlaceholderView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation
import SwiftUI

struct APODPlaceholderView: View {
    let text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.gray.opacity(0.2))
            .frame(height: 260)
            .overlay {
                VStack(spacing: 12) {
                    Image(systemName: "play.rectangle.fill")
                        .font(.largeTitle)
                    
                    Text(text)
                        .font(.headline)
                }
                .foregroundStyle(.secondary)
            }
    }
}
