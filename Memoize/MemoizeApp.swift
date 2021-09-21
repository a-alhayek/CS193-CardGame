//
//  MemoizeApp.swift
//  Memoize
//
//  Created by ahmad alhayek on 9/18/21.
//

import SwiftUI

@main
struct MemoizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: EmojiMemoryGame())
        }
    }
}
