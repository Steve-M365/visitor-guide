import Foundation

struct Guide: Codable {
    let title: String
    let updated: String?
    let sections: [Section]
}

struct Section: Codable, Identifiable {
    let icon: String
    let title: String
    let items: [Item]

    var id: String { title }
}

struct Item: Codable, Identifiable {
    let label: String
    let value: String

    var id: String { label }
}