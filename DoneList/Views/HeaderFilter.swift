import SwiftUI

struct HeaderFilter: View {
    @Binding var selectedItem: Int

    var body: some View {
        Picker(selection: $selectedItem) {
            Text("Todos")
                .tag(0)
            Text("Concluídos")
                .tag(1)
            Text("Não concluídos")
                .tag(2)
        } label: {
            Text("Selecione um filtro")
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    HeaderFilter(selectedItem: .constant(1))
}
