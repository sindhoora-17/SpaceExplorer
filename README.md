# Space Explorer — iOS NASA Data Explorer

A native iOS app for browsing NASA's open data: the Astronomy Picture of the Day,
NASA's image library, and near-Earth asteroid activity. Save anything you like to
Favorites.

Built with **SwiftUI** and **MVVM**, using **async/await** for all networking —
no third-party dependencies.

## Features

- **Astronomy Picture of the Day** — the daily image (or video) with its full
  explanation, and a detail view.
- **NASA image search** — search NASA's public image library by keyword, with a
  results grid and image detail.
- **Asteroid tracker** — near-Earth objects for a given date, with size, velocity,
  miss distance, and which ones are flagged potentially hazardous.
- **Favorites** — save items from any section; persisted locally so they survive
  app restarts.
- **Dark mode** support throughout.

## How it's built

- **MVVM.** Each feature has a `@MainActor` `ObservableObject` view model that owns
  its state; views observe `@Published` properties and stay free of networking code.
- **async/await networking.** A single `NASAService` exposes `async throws`
  methods over `URLSession`; the UI stays responsive while requests are in flight.
- **Explicit loading and error states.** Every view model tracks `isLoading` and
  `errorMessage`, so the UI shows a spinner or a readable error instead of
  freezing or failing silently.
- **Typed decoding.** Each API response decodes into `Codable` models
  (`APOD`, `NASAImage`, `Asteroid`) rather than untyped dictionaries.
- **Local persistence.** Favorites are JSON-encoded to `UserDefaults`.

## Project structure

```
├── SpaceExplorerApp.swift        app entry point
├── Models/                       Codable models: APOD, NASAImage, Asteroid, FavoriteItem
├── Services/
│   ├── NASAServices.swift        async/await networking against NASA's APIs
│   └── Secrets.swift             reads the API key from a gitignored plist
├── ViewModels/                   @MainActor ObservableObjects, one per feature
└── Views/                        SwiftUI views (APOD, search, asteroids, favorites)
```

## Setup

Requires Xcode 15+ and iOS 16+.

**1. Add your NASA API key.** Copy the example secrets file and fill in your key:

```bash
cp Secrets.example.plist Secrets.plist
```

Open `Secrets.plist` and replace `YOUR_NASA_API_KEY` with a key from
[api.nasa.gov](https://api.nasa.gov) (free, takes a minute).

In Xcode, make sure `Secrets.plist` is added to the app target
(select the file → File Inspector → check the target under *Target Membership*)
so it's bundled at build time.

`Secrets.plist` is gitignored and is never committed.

**2. Build and run.**

```bash
open SpaceExplorer.xcodeproj
```

> Without a key, the app falls back to NASA's public `DEMO_KEY`, which works but
> is rate-limited to roughly 30 requests per hour — fine for a quick look, not for
> real use.

## APIs used

| API | Endpoint |
|-----|----------|
| Astronomy Picture of the Day | `api.nasa.gov/planetary/apod` |
| NASA Image Library | `images-api.nasa.gov/search` |
| Near-Earth Object feed | `api.nasa.gov/neo/rest/v1/feed` |

## Tech

Swift · SwiftUI · MVVM · async/await · URLSession · Codable · UserDefaults