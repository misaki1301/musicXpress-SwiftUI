//
//  musicXpressApp.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/9/22.
//

import SwiftUI

@main
struct musicXpressApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var audioManager = MediaPlayerManager()
    @StateObject var audioFileManager = AudioFileManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(audioFileManager)
				.environmentObject(audioManager)
                .onAppear {
                    audioFileManager.fetchSongs()
                }
        }
    }
}
