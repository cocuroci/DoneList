//
//  DoneListApp.swift
//  DoneList
//
//  Created by Andre Cocuroci on 30/09/25.
//

import SwiftUI
import SwiftData

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

    init() {
        _viewModel = .init(initialValue: DoneListViewModel(context: sharedModelContainer.mainContext))
    }

    var body: some Scene {
        WindowGroup {
            BaseView()
        }
        .modelContext(sharedModelContainer.mainContext)
        .environment(viewModel)
    }
}
