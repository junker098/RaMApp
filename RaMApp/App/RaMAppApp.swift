//
//  RaMAppApp.swift
//  RaMApp
//
//  Created by Yuriy on 06.05.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct RaMAppApp: App {
    static let charactersStore = Store(initialState: CharactersListReducer.State()) {
        CharactersListReducer()
    }
    
    var body: some Scene {
        WindowGroup {
            CharactersListView(store: RaMAppApp.charactersStore)
        }
    }
}
