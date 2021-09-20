//
//  VoSoundsApp.swift
//  VoSounds
//
//  Created by Student on 20.09.21.
//

import SwiftUI

@main
struct VoSoundsApp: App {
    let persistenceController = PersistenceController.shared

    @StateObject var vm: SoundViewModel = SoundViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(vm)
        }
    }
}
