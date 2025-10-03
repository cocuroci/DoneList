import SwiftUI
import SwiftData

struct BaseView: View {
    @State private var selectedTab: Category

    init() {
        let firtTab = Category.allCases.first ?? .movies
        _selectedTab = State(initialValue: firtTab)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Category.allCases, id: \.self) { category in
                Tab(
                    category.rawValue,
                    systemImage: getTabImage(category: category),
                    value: category
                ) {
                    ListBaseView(category: category)
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
}

#Preview {
    BaseView()
        .modelContainer(SampleData.shared.modelContainer)
}
