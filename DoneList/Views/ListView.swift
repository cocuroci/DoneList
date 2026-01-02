import SwiftUI
import SwiftData

struct ListView: View {
    private let category: Category

    @Query private var itemsNotDone: [Item]
    @Query private var itemsDone: [Item]
    @State private var isExpanded = true
    @State private var showingAddItemView = false

    private var sort = [
        SortDescriptor<Item>(\.index, order: .forward),
        SortDescriptor<Item>(\.title, order: .forward)
    ]

    init(category: Category) {
        self.category = category

        _itemsNotDone = .init(filter: #Predicate { item in
            !item.done && item.typeRaw == category.rawValue
        }, sort: sort)

        _itemsDone = .init(filter: #Predicate { item in
            item.done && item.typeRaw == category.rawValue
        }, sort: sort)
    }

    var body: some View {
        NavigationStack {
            List {
                if itemsNotDone.isEmpty && itemsDone.isEmpty {
                    ContentUnavailableView("Sem resultados", systemImage: "tray")
                }

                if !itemsNotDone.isEmpty {
                    Section("Não concluídos") {
                        ForEach(itemsNotDone) { item in
                            ItemView(item: item)
                        }
                    }
                }

                if !itemsDone.isEmpty {
                    Section(isExpanded: $isExpanded) {
                        ForEach(itemsDone) { item in
                            ItemView(item: item)
                        }
                    } header: {
                        HStack {
                            Text("Concluídos (\(itemsDone.count))")
                            Spacer()
                            Button {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            } label: {
                                Image(systemName: "chevron.down")
                                    .rotationEffect(Angle(degrees: isExpanded ? 0 : -180))
                            }
                        }
                    }
                }
            }
            .navigationTitle(category.rawValue)
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddItemView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItemView) {
                AddItemView(category: category)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView(category: .movies)
            .modelContainer(SampleData.shared.modelContainer)
    }
}
