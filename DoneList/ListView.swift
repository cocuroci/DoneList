import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        VStack {
            HeaderFilter()
                .padding()
            if items.isEmpty {
                ContentUnavailableView("Sem resultado", systemImage: "tray")
            } else {
                List {
                    ForEach(items) { item in }
                }
            }
        }
    }
}

#Preview {
    ListView()
        .modelContainer(for: Item.self, inMemory: true)
}
