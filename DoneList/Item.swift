import Foundation
import SwiftData

@Model
final class Item {
    var title: String
    var done: Bool
    var category: Category

    init(title: String, done: Bool, category: Category) {
        self.title = title
        self.done = done
        self.category = category
    }
}

enum Category: String, CaseIterable, Identifiable {
    case movies
    case series
    case books

    var id: String {
        self.rawValue
    }
}
