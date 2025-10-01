import SwiftUI

struct HeaderFilter: View {
    @State private var selectedItem = 0

    var body: some View {
        Picker(selection: $selectedItem) {
            Text("Todos")
                .tag(0)
            Text("Concluídos")
                .tag(1)
            Text("Não concluídos")
                .tag(2)
        } label: {
            Text("oie")
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    HeaderFilter()
}
