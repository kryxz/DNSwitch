//
//  DNSwitchApp.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/04.
//

import SwiftUI

@main
struct DNSwitchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
