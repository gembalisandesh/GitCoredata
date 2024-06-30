//
//  GitCoredataApp.swift
//  GitCoredata
//
//  Created by user263604 on 6/30/24.
//

import SwiftUI

@main
struct GitCoredataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView(context: persistenceController.container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
