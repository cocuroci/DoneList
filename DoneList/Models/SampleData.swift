import SwiftData

@MainActor
final class SampleData {
    static let shared = SampleData()

    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }

    init() {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])

            context.insert(Item(title: "O Poderoso Chefão", done: false, category: .movies))
            context.insert(Item(title: "Breaking Bad", done: true, category: .series))
            context.insert(Item(title: "1984", done: false, category: .books))

            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
