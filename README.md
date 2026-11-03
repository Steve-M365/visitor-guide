# Visitor Guide

An offline-capable Apple TV visitor guide built with SwiftUI and GitHub Pages.

## Update the guide

1. Edit `guide.json` in GitHub, or use a Git-based CMS such as TinaCMS.
2. Commit to `main`.
3. GitHub Pages publishes the updated JSON.
4. The Apple TV app fetches the update on next launch and caches it for offline use.

## JSON endpoint

https://steve-m365.github.io/visitor-guide/guide.json

## Apple TV app

Open `VisitorGuide.xcodeproj` in Xcode, set your signing team and Bundle Identifier, then run it on your Apple TV. The app fetches `guide.json`, caches it in Documents, and falls back to the cached copy when offline.