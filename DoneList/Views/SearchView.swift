import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        NavigationStack {
            Text("SearchView")
        }
        .navigationTitle("Busca")
        .searchable(text: $text)
        .searchFocused($isSearchFocused)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                self.isSearchFocused = true
            }
        }
    }
}
