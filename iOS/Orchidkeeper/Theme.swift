import SwiftUI

enum Theme {
    static let background = Color(red: 0.141, green: 0.071, blue: 0.125)
    static let accent = Color(red: 0.761, green: 0.388, blue: 0.659)
    static let accent2 = Color(red: 0.498, green: 0.749, blue: 0.541)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
