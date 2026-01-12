import SwiftUI
import SwiftData

struct ListView: View {
    private let category: Category

    @State private var isExpanded = true
    @State private var showingAddItemView = false
    @Environment(DoneListViewModel.self) var viewModel

    private var sort = [
        SortDescriptor<Item>(\.index, order: .forward),
        SortDescriptor<Item>(\.title, order: .forward)
    ]

    init(category: Category) {
        self.category = category
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

                if !viewModel.itemsDone.isEmpty {
                    Section(isExpanded: $isExpanded) {
                        ForEach(viewModel.itemsDone) { item in
                            ItemView(item: item)
                        }
                    } header: {
                        HStack {
                            Text("Concluídos (\(viewModel.itemsDone.count))")
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
