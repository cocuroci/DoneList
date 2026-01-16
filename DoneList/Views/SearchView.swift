import SwiftUI

struct SearchView: View {
    @Environment(SearchViewModel.self) var viewModel
    @State private var query = ""

    var body: some View {
        NavigationStack {
            if !query.isEmpty {
                Text("Resultados para: \(query)")
            }
            List(viewModel.searchResults) { item in
                ItemView(item: item)
            }
            .navigationTitle("Resultado da busca")
        }
        .searchable(text: $query)
        .textInputAutocapitalization(.never)
        .onChange(of: query) { oldValue, newValue in
            viewModel.executeSearch(query: newValue)
        }
    }
}

#Preview {
    SearchView()
        .environment(sampleSearchViewModel)
}
