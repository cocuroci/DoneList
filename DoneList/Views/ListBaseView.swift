import SwiftUI
import SwiftData

struct ListBaseView: View {
    private let categoty: Category
    @State private var filterSelected = 0
    @State var predicate: Predicate<Item>

    init(category: Category) {
        self.categoty = category

        _predicate = State(initialValue: #Predicate<Item> { item in
            category.rawValue == item.typeRaw
        })
    }

    var body: some View {
        NavigationStack {
            ListView(predicate: predicate, filterSelected: $filterSelected)
                .onChange(of: filterSelected) { oldValue, newValue in
                    switch newValue {
                    case 1:
                        predicate = #Predicate<Item> { item in
                            categoty.rawValue == item.typeRaw && item.done
                        }
                    case 2:
                        predicate = #Predicate<Item> { item in
                            categoty.rawValue == item.typeRaw && !item.done
                        }
                    default:
                        predicate = #Predicate<Item> { item in
                            categoty.rawValue == item.typeRaw
                        }
                    }
                }
                .navigationTitle(categoty.rawValue)
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
}

#Preview {
    ListBaseView(category: .movies)
        .modelContainer(SampleData.shared.modelContainer)
}
