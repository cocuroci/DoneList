import SwiftUI
import SwiftData

struct ListView: View {
    private let category: Category

    @State private var showingAddItemView = false
    @State private var isExpandedSections = Set<Int>()
    @Environment(DoneListViewModel.self) var viewModel

    init(category: Category) {
        self.category = category
    }

    private func updatedExpandedSection(isExpanded: Bool, key: Int) {
        if isExpanded {
            isExpandedSections.insert(key)
        } else {
            isExpandedSections.remove(key)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if viewModel.itemsNotDone.isEmpty && viewModel.groupedDoneItems.isEmpty {
                    ContentUnavailableView("Sem resultados", systemImage: "tray")
                }

                if !viewModel.itemsNotDone.isEmpty {
                    Section("Não concluídos") {
                        ForEach(viewModel.itemsNotDone) { item in
                            ItemView(item: item)
                        }.onDelete { indexSet in
                            viewModel.removeItem(indexSet: indexSet, with: category)
                        }
                    }
                }

                if !viewModel.groupedDoneItems.isEmpty {
                    ForEach(viewModel.groupedDoneItems, id: \.key) { group in
                        Section(isExpanded: Binding(get: {
                            isExpandedSections.contains(group.key)
                        }, set: { isExpanded in
                            updatedExpandedSection(isExpanded: isExpanded, key: group.key)
                        })) {
                            ForEach(group.value) { item in
                                ItemView(item: item)
                            }
                        } header: {
                            Text("Concluídos em \(group.key.description) (\(group.value.count))")
                        }
                    }
                }
            }
            .navigationTitle(category.rawValue)
            .listStyle(.sidebar)
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
            .onAppear {
                viewModel.fetchItems(category: category)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView(category: .movies)
            .environment(sampleViewModel)
    }
}
