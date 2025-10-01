import Foundation
import SwiftData

@Model
final class Item {
    var title: String
    var done: Bool
    var index: Int

    var category: Category {
        get { Category(rawValue: typeRaw) ?? .movies }
        set { typeRaw = newValue.rawValue }
    }

    private(set) var typeRaw: Category.RawValue

    init(title: String, done: Bool, category: Category) {
        self.title = title
        self.done = done
        self.typeRaw = category.rawValue
        self.index = done ? 1 : 0
    }
}

enum Category: String, CaseIterable, Codable {
    case movies
    case series
    case books

    var rawValue: String {
        switch self {
        case .movies: return "Filmes"
        case .series: return "Séries"
        case .books: return "Livros"
        }
    }
}
