import Foundation
import Combine
import SwiftUI
import SwiftData

@Observable
final class SearchViewModel {
    private let sort: [SortDescriptor<Item>] = [.init(\.index, order: .forward), .init(\.title, order: .forward)]
    private let context: ModelContext
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []
    @ObservationIgnored @Published private var searchTerm = ""

    var searchResults: [Item] = []

    init(context: ModelContext) {
        self.context = context

        $searchTerm
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.fetchSearchResults(query: value)
            })
            .store(in: &cancellables)
    }

    func executeSearch(query: String) {
        searchTerm = query
    }

    private func fetchSearchResults(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }

        let queryFetchDescriptor = FetchDescriptor<Item>(predicate: filter(query: query), sortBy: sort)

        do {
            searchResults = try context.fetch(queryFetchDescriptor)
        } catch {
            searchResults = []
        }
    }

    private func filter(query: String) -> Predicate<Item> {
        #Predicate { $0.title.localizedStandardContains(query) }
    }
}
