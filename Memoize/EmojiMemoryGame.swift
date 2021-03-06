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
            return ["๐ถ","๐ฑ","๐น","๐ฐ","๐ฆ","๐ป","๐ผ","๐ปโโ๏ธ","๐จ","๐ฏ","๐ฎ","๐ท","๐ฆ","๐ฅ","๐ฆ","๐ชณ","๐"]
        case .Fruits:
            return ["๐","๐","๐","๐","๐","๐","๐","๐","๐","๐ซ","๐","๐","๐","๐ฅญ","๐","๐ฅฅ","๐ฅ"]
        case .Cars:
            return ["๐","๐","๐","๐","๐","๐","๐","๐","๐","๐ป","๐","๐","๐","๐","๐ด","๐ต","๐"]
        case .Flags:
            return ["๐ณ๏ธ","๐ฆ๐ฝ","๐ดโโ ๏ธ","๐ฉ","๐ณ๏ธโ๐","๐ณ๏ธโโง๏ธ","๐ฆ๐ซ","๐จ๐ฆ","๐จ๐ฑ","๐จ๐ฎ","๐จ๐จ","๐จ๐ฐ","๐ง๐ญ","๐ง๐ท","๐ณ๐ช","๐พ๐ช","๐ช๐ญ"]
        case .Emojis:
            return ["๐","๐น","๐","๐คฅ","๐คซ","๐ฅณ","๐ฅธ","๐ฅต","๐จ","๐ถโ๐ซ๏ธ","๐ฅถ","๐","๐คจ","๐","๐","๐","๐"]
        case .Tools:
           return ["๐ ","โ","๐จ","๐ง","๐งฐ","โ๏ธ","๐","๐ฆ ","๐งช","๐ก","๐งน","๐งฒ","๐ฏ","๐งฝ","๐","๐","โ๏ธ"]
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
