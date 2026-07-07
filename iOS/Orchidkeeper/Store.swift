import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 8

    @Published var items: [CareEvent] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("orchidkeeper_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: CareEvent) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: CareEvent) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: CareEvent) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([CareEvent].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [CareEvent] {
        [
        CareEvent(date: Date().addingTimeInterval(-86400), orchidName: "Windowsill Phal", variety: "Phalaenopsis", eventType: "Watered"),
        CareEvent(date: Date().addingTimeInterval(-172800), orchidName: "Cattleya #2", variety: "Cattleya", eventType: "Fed"),
        CareEvent(date: Date().addingTimeInterval(-259200), orchidName: "Mini Phal", variety: "Phalaenopsis", eventType: "Repotted")
        ]
    }
}
