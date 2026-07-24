//
//  SpaceExplorerApp.swift
//  SpaceExplorer
//
//  Created by Sindhoora on 5/24/26.
//

import SwiftUI

@main
struct SpaceExplorerApp: App {

    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
