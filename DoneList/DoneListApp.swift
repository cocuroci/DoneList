//
//  DoneListApp.swift
//  DoneList
//
//  Created by Andre Cocuroci on 30/09/25.
//

import SwiftUI
import SwiftData

let sampleViewModel = DoneListViewModel(context: SampleData.shared.context)
let sampleSearchViewModel = SearchViewModel(context: SampleData.shared.context)

@main
struct DoneListApp: App {
    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @State private var viewModel: DoneListViewModel
    @State private var searchViewModel: SearchViewModel

    init() {
        _viewModel = .init(initialValue: DoneListViewModel(context: sharedModelContainer.mainContext))
        _searchViewModel = .init(initialValue: SearchViewModel(context: sharedModelContainer.mainContext))
    }

    var body: some Scene {
        WindowGroup {
            BaseView()
        }
        .environment(viewModel)
        .environment(searchViewModel)
    }
}
