//
//  Jokes_GameApp.swift
//  Jokes Game
//
//  Created by John Vea on 12/2/24.
//

import SwiftUI

@main
struct Jokes_GameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
