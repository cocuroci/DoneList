import Foundation
import SwiftData

@Observable
final class DoneListViewModel {
    private let context: ModelContext
    private let sort = [
        SortDescriptor<Item>(\.index, order: .forward),
        SortDescriptor<Item>(\.title, order: .forward)
    ]

    var itemsNotDone: [Item] = []
    var itemsDone: [Item] = []

    init(context: ModelContext) {
        self.context = context
    }

    func fetchItems(category: Category) {
        let itemsNotDoneFetchDescriptor = FetchDescriptor<Item>(predicate: #Predicate { item in
            !item.done && item.typeRaw == category.rawValue
        }, sortBy: sort)

        let itemsDoneFetchDescriptor = FetchDescriptor<Item>(predicate: #Predicate { item in
            item.done && item.typeRaw == category.rawValue
        }, sortBy: sort)

        do {
            itemsNotDone = try context.fetch(itemsNotDoneFetchDescriptor)
            itemsDone = try context.fetch(itemsDoneFetchDescriptor)
        } catch {
            debugPrint(error)
        }
    }

    func addItem(title: String, category: String) {
        guard !title.isEmpty, !category.isEmpty else { return }
        guard let category = Category(rawValue: category) else { return }

        context.insert(Item(title: title, category: category))
        try? context.save()
    }
}
