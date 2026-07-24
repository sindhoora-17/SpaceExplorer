//
//  Secrets.swift
//  SpaceExplorer
//
//

import Foundation

/// Reads the NASA API key from a gitignored `Secrets.plist`.
///
/// Falls back to NASA's public `DEMO_KEY` so the app still runs for anyone who
/// clones the repo without their own key (DEMO_KEY is rate-limited to roughly
/// 30 requests/hour). Get a free key at https://api.nasa.gov.
enum Secrets {
    static var nasaAPIKey: String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(
                from: data, format: nil
            ) as? [String: Any],
            let key = plist["NASA_API_KEY"] as? String,
            !key.isEmpty,
            key != "YOUR_NASA_API_KEY"
        else {
            return "DEMO_KEY"
        }
        return key
    }
}
