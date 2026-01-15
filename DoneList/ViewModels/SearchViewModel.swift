import Foundation
import Combine
import SwiftUI
import SwiftData

@Observable
final class SearchViewModel {
    private let sort: [SortDescriptor<Item>] = [.init(\.index, order: .forward), .init(\.title, order: .forward)]
    private let context: ModelContext
    private var cancellables: Set<AnyCancellable> = []
    @ObservationIgnored @Published private var searchTerm = ""

    var searchResults: [Item] = []

    init(context: ModelContext) {
        self.context = context

        $searchTerm
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: fetchSearchResults)
            .store(in: &cancellables)
    }

    func executeSearch(text: String) {
        searchTerm = text
    }

    private func fetchSearchResults(text: String) {
        guard !text.isEmpty else {
            return
        }

        let query = FetchDescriptor<Item>(predicate: #Predicate { item in
            item.title.contains(text)
        }, sortBy: sort)

        do {
            searchResults = try context.fetch(query)
        } catch {
            searchResults = []
        }
    }
}
