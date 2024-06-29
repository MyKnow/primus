//
//  primusApp.swift
//  primus
//
//  Created by 정민호 on 6/26/24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct primusApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    

    var body: some Scene {
        WindowGroup {
//            ContentView()
            MainView(store: Store(
                initialState: .init(),
                reducer: { MainTabViewReducer() }))
        }
//        .modelContainer(sharedModelContainer)
    }
}
