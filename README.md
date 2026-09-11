# Space Explorer — iOS NASA Data Explorer

A native iOS app for browsing NASA's open data: the Astronomy Picture of the Day,
NASA's image library, and near-Earth asteroid activity. Save anything you like to
Favorites.

Built with **SwiftUI** and **MVVM**, using **async/await** for networking and no
third-party dependencies.

## Features

- **Astronomy Picture of the Day** — the daily image (or video) with its full
  explanation and a detail view.
- **NASA image search** — search NASA's public image library by keyword, with a
  results grid and image detail.
- **Asteroid tracker** — near-Earth objects for a selected date, including size,
  velocity, miss distance, and potentially hazardous status.
- **Favorites** — save items from any section; persisted locally so they survive
  app restarts.
- **Dark mode** support throughout.

## How it's built

- **MVVM.** Each feature has a `@MainActor` `ObservableObject` view model that owns
  its state; views observe `@Published` properties and stay free of networking code.
- **async/await networking.** `NASAServices` uses `URLSession` with structured
  concurrency and validates HTTP responses before decoding them.
- **Safe URL construction.** NASA request URLs are built with `URLComponents` and
  `URLQueryItem`, so search terms and API parameters are encoded correctly.
- **Explicit loading and error states.** View models track `isLoading` and
  `errorMessage`, so the UI can surface progress and failures instead of failing silently.
- **Typed decoding.** API responses decode into `Codable` models such as `APOD`,
  `NASAImage`, and `Asteroid` rather than untyped dictionaries.
- **Local persistence.** Favorites are JSON-encoded to `UserDefaults`.
- **Secret handling.** The NASA API key is loaded from a gitignored plist and falls
  back to NASA's public `DEMO_KEY` when a local key is unavailable.

## Project structure

```text
├── SpaceExplorerApp.swift        app entry point
├── Models/                       Codable response + favorite models
├── Services/
│   ├── NASAServices.swift        async/await networking against NASA APIs
│   └── Secrets.swift             reads the API key from a gitignored plist
├── ViewModels/                   @MainActor ObservableObjects, one per feature
└── Views/                        SwiftUI views for APOD, search, asteroids, favorites
```

## Setup

The project was last saved with **Xcode 26.2** and its current project settings
target **iOS 26.2**.

### 1. Add a NASA API key

Copy the example secrets file and fill in your key:

```bash
cp SpaceExplorer/Secrets.example.plist SpaceExplorer/Secrets.plist
```

Open `Secrets.plist` and replace `YOUR_NASA_API_KEY` with a free key from
[api.nasa.gov](https://api.nasa.gov).

In Xcode, make sure `Secrets.plist` is included in the app target so it is bundled
at build time. The file is gitignored and should never be committed.

Without a local key, the app automatically falls back to NASA's public
`DEMO_KEY`, which is useful for trying the project but has much lower rate limits.

### 2. Build and run

```bash
open SpaceExplorer.xcodeproj
```

## APIs used

| API | Endpoint |
|-----|----------|
| Astronomy Picture of the Day | `api.nasa.gov/planetary/apod` |
| NASA Image Library | `images-api.nasa.gov/search` |
| Near-Earth Object feed | `api.nasa.gov/neo/rest/v1/feed` |

## Tech

Swift · SwiftUI · MVVM · async/await · URLSession · Codable · UserDefaults

## Notes

The project currently has no automated test target. Networking is isolated in
`NASAServices`, which makes dependency injection and unit testing a natural next
step if the app is extended further.
