import SwiftUI
import SwiftData

struct ItemView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isDone: Bool

    private let item: Item

    init(item: Item) {
        self.item = item
        _isDone = .init(initialValue: item.done)
    }

    var body: some View {
        HStack {
            Text(item.title)
            Spacer()
            Toggle("Alterar", isOn: $isDone)
                .labelsHidden()
        }
        .onChange(of: isDone) { oldValue, newValue in
            item.done = newValue
            try? modelContext.save()
        }
    }
}

#Preview {
    ItemView(item: .init(title: "O Poderoso Chefão", done: true, category: .movies))
}
