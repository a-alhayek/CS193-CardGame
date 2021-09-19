//
//  EmojiMemoryGame.swift
//  Memoize
//
//  Created by ahmad alhayek on 9/18/21.
//

import SwiftUI

enum EmojiKind: Hashable {
    case Animals
    case Fruits
    case Cars
    case Flags
    case Emojis
    case Tools
    case newTheme([String], name: String)
    
    var systemName: String {
        switch self {
        case .Cars:
            return "car"
        case .Flags:
            return "flag"
        default:
            return "questionmark.circle"

        }
    }
    
    var name: String {
        switch self {
        case .Animals:
            return "Animals"
        case .Fruits:
            return "Fruits"
        case .Cars:
            return "Cars"
        case .Flags:
            return "Flags"
        case .Emojis:
            return "Emojis"
        case .Tools:
            return "Tools"
        case .newTheme(_, let name):
            return name
        }
    }
    
    var emojis: [String]  {
        switch self {
        case .Animals:
            return ["🐶","🐱","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🐮","🐷","🐦","🐥","🦋","🪳","🐙"]
        case .Fruits:
            return ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝"]
        case .Cars:
            return ["🚗","🚕","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚜","🚛","🚔","🛴","🛵","🚖"]
        case .Flags:
            return ["🏳️","🇦🇽","🏴‍☠️","🚩","🏳️‍🌈","🏳️‍⚧️","🇦🇫","🇨🇦","🇨🇱","🇨🇮","🇨🇨","🇨🇰","🇧🇭","🇧🇷","🇳🇪","🇾🇪","🇪🇭"]
        case .Emojis:
            return ["🎃","👹","😈","🤥","🤫","🥳","🥸","🥵","😨","😶‍🌫️","🥶","😎","🤨","😋","😁","😃","😀"]
        case .Tools:
           return ["🛠","⚒","🔨","🔧","🧰","⚖️","💈","🦠","🧪","🌡","🧹","🧲","📯","🧽","🔒","📎","✏️"]
        case .newTheme(let array, _):
            return array
        }
    }
}


class EmojiMemoryGame: ObservableObject {
    static func createModel() -> MemoryGame<String> {
        MemoryGame<String>() {
            Array.init(EmojiKind.Emojis.emojis[0..<$0])
       }
    }
    @Published private(set) var model = createModel()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: Intent(s)

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
