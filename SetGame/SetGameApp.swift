//
//  SetGameApp.swift
//  SetGame
//
//  Created by Samuel Alake on 1/21/22.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(setGame: SetGameVM())
        }
    }
}
