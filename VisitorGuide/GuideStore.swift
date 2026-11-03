import Foundation

@MainActor
final class GuideStore: ObservableObject {
    @Published var guide: Guide?
    @Published var lastUpdated: Date?
    @Published var isOffline = false
    @Published var errorMessage: String?

    private let remoteURL = URL(string: "https://steve-m365.github.io/visitor-guide/guide.json")!

    private var localURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("guide.json")
    }

    func load() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: remoteURL)
            let decoded = try JSONDecoder().decode(Guide.self, from: data)

            try data.write(to: localURL, options: .atomic)
            let now = Date()
            UserDefaults.standard.set(now, forKey: "guideLastUpdated")

            guide = decoded
            lastUpdated = now
            isOffline = false
            errorMessage = nil
        } catch {
            isOffline = true
            errorMessage = error.localizedDescription

            if let data = try? Data(contentsOf: localURL),
               let cached = try? JSONDecoder().decode(Guide.self, from: data) {
                guide = cached
                lastUpdated = UserDefaults.standard.object(forKey: "guideLastUpdated") as? Date
            }
        }
    }
}