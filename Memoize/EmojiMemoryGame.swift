//
//  EmojiMemoryGame.swift
//  Memoize
//
//  Created by ahmad alhayek on 9/18/21.
//

import SwiftUI

enum EmojiKind: String, Hashable, CaseIterable {
 
    
    case Animals
    case Fruits
    case Cars
    case Flags
    case Emojis
    case Tools
    case Random
    
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
    
    var emojis: [String]?  {
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
        case .Random:
            return EmojiKind.allCases.shuffled().first?.emojis
        }
    }
}


class EmojiMemoryGame: ObservableObject {
    @Published var newGamepressed = false
    
    static func createModel() -> MemoryGame<String> {
        MemoryGame<String>(themeName: EmojiKind.Emojis.rawValue) {
            Array.init(EmojiKind.Emojis.emojis?[0..<$0] ?? [] )
       }
    }
    @Published private(set) var model = createModel()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeName: String {
        model.themeName
    }
    
    var score: Int {
        model.score
    }
    
    func userPressedNewGame() {
        newGamepressed.toggle()
    }
    func selctedNewTypeOfEmojies(emojiKind: EmojiKind) {
        if let emojis = emojiKind.emojis {
            model = MemoryGame<String>(themeName: emojiKind.rawValue) {
                Array.init(emojis[0..<$0])
            }
        }
        
        newGamepressed.toggle()
    }
    //MARK: Intent(s)

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
