import SwiftUI
import SwiftData

struct ListView: View {
    @Binding var filterSelected: Int
    @Query private var items: [Item]

    private var sort = [
        SortDescriptor<Item>(\.index, order: .forward),
        SortDescriptor<Item>(\.title, order: .forward)
    ]

    init(predicate: Predicate<Item>, filterSelected: Binding<Int>) {
        _items = .init(filter: predicate, sort: sort)
        _filterSelected = Binding(projectedValue: filterSelected)
    }

    var body: some View {
        List {
            Section {
                if items.isEmpty {
                    ContentUnavailableView("Sem resultado", systemImage: "tray")
                } else {
                    ForEach(items) { item in
                        ItemView(item: item)
                    }
                }
            } header: {
                HeaderFilter(selectedItem: $filterSelected)
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    ListView(predicate: .true, filterSelected: .constant(0))
        .modelContainer(SampleData.shared.modelContainer)
}
