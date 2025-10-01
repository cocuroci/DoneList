import SwiftUI
import SwiftData

struct BaseView: View {
    @State private var selectedTab: Category

    init() {
        let firtTab = Category.allCases.first ?? .movies
        _selectedTab = State(initialValue: firtTab)
    }

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ForEach(Category.allCases, id: \.self) { category in
                    Tab(
                        category.rawValue,
                        systemImage: getTabImage(category: category),
                        value: category
                    ) {
                        ListView()
                    }
                }
            }
            .navigationTitle("DoneList")
            .toolbar {
                ToolbarItem {
                    Button {

                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func getTabImage(category: Category) -> String {
        switch category {
        case .movies:
            return "film"
        case .series: 
            return "tv"
        case .books: 
            return "book"
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    BaseView()
}
