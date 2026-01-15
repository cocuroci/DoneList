import Foundation
import Combine
import SwiftData

@Observable
final class SearchViewModel {
    private let sort: [SortDescriptor<Item>] = [.init(\.index, order: .forward), .init(\.title, order: .forward)]
    private let context: ModelContext
    private var cancellables: Set<AnyCancellable> = []

    @Published var searchText: String = ""
    var searchResults: [Item] = []

    init(context: ModelContext) {
        self.context = context

        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: executeSearch)
            .store(in: &cancellables)
    }

    private func executeSearch(text: String) {
        let query = FetchDescriptor<Item>(predicate: #Predicate { item in
            item.title.localizedStandardContains(text)
        }, sortBy: sort)

        do {
            searchResults = try context.fetch(query)
        } catch {
            searchResults = []
        }
    }
}
