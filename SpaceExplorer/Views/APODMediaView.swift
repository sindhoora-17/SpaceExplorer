//
//  APODMediaView.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import Foundation
import SwiftUI
import WebKit

struct APODMediaView: View {
    let apod: APOD
    
    var body: some View {
        if apod.media_type == "image" {
            AsyncImage(url: URL(string: apod.url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 260)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        } else {
            ZStack {
                LinearGradient(
                    colors: [.black, .blue.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                VStack(spacing: 12) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.white)
                    
                    Text("NASA Video")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text("Tap View Details to watch")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            .frame(height: 260)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
}
