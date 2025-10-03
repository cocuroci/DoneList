import SwiftUI
import SwiftData

struct ItemView: View {
    @Bindable var item: Item

    var body: some View {
        HStack {
            Text(item.title)
            Spacer()
            Toggle("Alterar", isOn: $item.done)
                .labelsHidden()
        }
    }
}

#Preview {
    ItemView(item: .init(title: "Item de teste", category: .movies))        
}
