import SwiftUI

struct SearchView: View {
    @Environment(SearchViewModel.self) var viewModel
    @State private var query = ""
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.searchResults) { item in
                    ItemView(item: item)
                }
            }
            .navigationTitle("Resultado da busca")
        }
        .searchable(text: $query)
        .searchFocused($isSearchFocused)
        .textInputAutocapitalization(.never)
        .onChange(of: query) { oldValue, newValue in
            viewModel.executeSearch(text: newValue)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                self.isSearchFocused = true
            }
        }
    }
}
