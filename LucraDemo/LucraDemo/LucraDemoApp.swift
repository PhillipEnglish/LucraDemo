//
//  LucraDemoApp.swift
//  LucraDemo
//
//  Created by Phillip English on 11/9/24.
//

import SwiftUI
import SwiftData

@main
struct LucraDemoApp: App {
    
    let modelContainer: ModelContainer
    
    init() {
        // Initializing ModelContainer with the Album model.. This shouldn't fail but if it does at this point I want the error to be fatal
        modelContainer = try! ModelContainer(for: Album.self)
        modelContainer.mainContext.autosaveEnabled = false
    }
    var body: some Scene {
        WindowGroup {
            AlbumSearchView(viewModel: AlbumViewModel(), modelContext: modelContainer.mainContext)
        }
    }
}
