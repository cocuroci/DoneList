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

    private func updatedExpandedSection(key: Int) {
        if isExpandedSections.contains(key) {
            isExpandedSections.remove(key)
        } else {
            isExpandedSections.insert(key)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if viewModel.itemsNotDone.isEmpty && viewModel.itemsDone.isEmpty {
                    ContentUnavailableView("Sem resultados", systemImage: "tray")
                }

                if !viewModel.itemsNotDone.isEmpty {
                    Section("Não concluídos") {
                        ForEach(viewModel.itemsNotDone) { item in
                            ItemView(item: item)
                        }
                    }
                }

                if !viewModel.groupedDoneItems.isEmpty {
                    ForEach(viewModel.groupedDoneItems, id: \.key) { group in
                        Section(isExpanded: Binding(get: {
                            isExpandedSections.contains(group.key)
                        }, set: { value in
                            updatedExpandedSection(key: group.key)
                        })) {
                            ForEach(group.value) { item in
                                ItemView(item: item)
                            }
                        } header: {
                            HStack {
                                Text("Concluídos em \(group.key.description) (\(group.value.count))")
                                Spacer()
                                Button {
                                    withAnimation {
                                        updatedExpandedSection(key: group.key)
                                    }
                                } label: {
                                    Image(systemName: "chevron.down")
                                        .rotationEffect(Angle(degrees: isExpandedSections.contains(group.key) ? 0 : -180))
                                }
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
            .onAppear {
                viewModel.fetchItems(category: category)
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
