import SwiftUI

struct ContentView: View {
    @StateObject private var store = GuideStore()

    var body: some View {
        NavigationStack {
            Group {
                if let guide = store.guide {
                    List(guide.sections) { section in
                        NavigationLink(value: section) {
                            Label(section.title, systemImage: section.icon)
                        }
                    }
                    .navigationTitle(guide.title)
                    .navigationDestination(for: Section.self) { section in
                        SectionDetail(section: section)
                    }
                } else if let error = store.errorMessage {
                    ContentUnavailableView("Guide unavailable", systemImage: "wifi.exclamationmark", description: Text(error))
                } else {
                    ProgressView("Loading guide")
                }
            }
            .overlay(alignment: .bottom) {
                if store.isOffline {
                    Text("Offline — showing saved guide")
                        .font(.footnote)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.thinMaterial, in: Capsule())
                        .padding(.bottom, 24)
                }
            }
            .task { await store.load() }
        }
    }
}

struct SectionDetail: View {
    let section: Section

    var body: some View {
        List(section.items) { item in
            HStack {
                Text(item.label)
                Spacer()
                Text(item.value)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(section.title)
    }
}