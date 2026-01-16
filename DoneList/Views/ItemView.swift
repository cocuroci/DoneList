import SwiftUI
import SwiftData

struct ItemView: View {
    @Environment(DoneListViewModel.self) var viewModel
    var item: Item

    private var isDone: Binding<Bool> {
        .init {
            item.done
        } set: { isDone in
            viewModel.toogleDoneItem(item, isDone: isDone)
        }
    }

    var body: some View {
        HStack {
            Text(item.title)
            Spacer()
            Toggle("Alterar", isOn: isDone)
                .labelsHidden()
        }
    }
}

#Preview {
    ItemView(item: .init(title: "Item de teste", category: .movies))
        .environment(sampleViewModel)
}
