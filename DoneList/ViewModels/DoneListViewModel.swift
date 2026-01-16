import Foundation
import SwiftData
import SwiftUI

@Observable
final class DoneListViewModel {
    private let context: ModelContext
    private let sort: [SortDescriptor<Item>] = [.init(\.index, order: .forward), .init(\.title, order: .forward)]
    private var itemsDone: [Item] = []

    var itemsNotDone: [Item] = []
    var groupedDoneItems: [(key: Int, value: [Item])] = []

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

            groupedDoneItems = Dictionary(grouping: itemsDone) { item in
                guard let completedDate = item.completedDate else { return 2025 }
                return Calendar.current.component(.year, from: completedDate)
            }.sorted { $0.key > $1.key }
        } catch {
            debugPrint(error)
        }
    }

    func addItem(title: String, category: String) {
        guard !title.isEmpty, !category.isEmpty else { return }
        guard let category = Category(rawValue: category) else { return }

        context.insert(Item(title: title, category: category))
        try? context.save()

        fetchItems(category: category)
    }

    func toogleDoneItem(_ item: Item, isDone: Bool) {
        item.done = isDone
        item.completedDate = isDone ? Date() : nil

        fetchItems(category: item.category)
    }

    func removeItem(indexSet: IndexSet, with category: Category) {
        for index in indexSet {
            context.delete(itemsNotDone[index])
        }

        try? context.save()

        fetchItems(category: category)
    }
}
