import Foundation
import SwiftData

@Model
final class Item {
    var title: String
    var done: Bool
    var index: Int
    var completedDate: Date?

    var category: Category {
        get { Category(rawValue: typeRaw) ?? .movies }
        set { typeRaw = newValue.rawValue }
    }

    private(set) var typeRaw: Category.RawValue

    init(title: String, done: Bool = false, category: Category, completedDate: Date? = nil) {
        self.title = title
        self.done = done
        self.typeRaw = category.rawValue
        self.index = done ? 1 : 0
        self.completedDate = completedDate
    }
}

enum Category: String, CaseIterable, Codable, Equatable {
    case movies = "Filmes"
    case series = "Séries"
    case books = "Livros"
    case games = "Games"
    case search = "Busca"

    var icon: String {
        switch self {
        case .movies:
            return "film"
        case .series:
            return "tv"
        case .books:
            return "book"
        case .games:
            return "gamecontroller"
        case .search:
            return "search"
        }
    }
}
