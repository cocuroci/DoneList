import SwiftUI
import SwiftData

struct BaseView: View {
    var body: some View {
        NavigationStack {
            ListView()
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
