import Foundation

struct CareEvent: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var orchidName: String
    var variety: String
    var eventType: String
}
