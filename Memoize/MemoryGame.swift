//
//  MemoryGame.swift
//  Memoize
//
//  Created by ahmad alhayek on 9/18/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cardsNumberDefault = 8
    private(set) var cards: Array<Card>
    private var indexOfTheOneFaceUpCard: Int?
    
    init(createCardContent: (Int) -> [CardContent]) {
        cards = Array<Card>()
        createCardContent(cardsNumberDefault).forEach {
            cards.append(Card(id: UUID(), content: $0))
            cards.append(Card(id: UUID(), content: $0))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[choosenIndex].isFaceUp,
           !cards[choosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneFaceUpCard {
                if cards[choosenIndex].content == cards[potentialMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneFaceUpCard = choosenIndex
            }
            cards[choosenIndex].isFaceUp.toggle()
        }
    }
    
    struct Card: Identifiable {
        var id: UUID
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isViewedBefore: Bool = true
        var content: CardContent
    }
}
