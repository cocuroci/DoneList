import SwiftData
import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(DoneListViewModel.self) var viewModel

    @State private var title: String = ""
    @State private var category: String = Category.movies.rawValue

    init(category: Category = .movies) {
        _category = State(initialValue: category.rawValue)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Título", text: $title)
                    Picker("Categoria", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category.rawValue)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Fechar")
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveItem()
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    .accessibilityLabel("Enviar")
                }
            }
        }
    }

    private func saveItem() {
        viewModel.addItem(title: title, category: category)
        dismiss()
    }
}

#Preview {
    AddItemView()
        .environment(sampleViewModel)
}
