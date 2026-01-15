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
                if category != .search {
                    Tab(
                        category.rawValue,
                        systemImage: category.icon,
                        value: category
                    ) {
                        ListView(category: category)
                    }
                } else {
                    Tab(value: category, role: .search) {
                        SearchView()
                    }
                }
            }
        }
    }
}

#Preview {
    BaseView()
        .environment(sampleViewModel)
}
