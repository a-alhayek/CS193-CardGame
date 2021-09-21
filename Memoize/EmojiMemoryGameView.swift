//
//  ContentView.swift
//  Memoize
//
//  Created by ahmad alhayek on 9/18/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 5) {
                VStack(alignment: .center, spacing: 5) {
                    Text("Score:").font(.title3)
                    Text("\(game.score)").font(.title3)
                }
                
               Spacer()
    
                    Button {
                        game.userPressedNewGame()
                    } label: {
                        Text("New Game").font(.title3)
                    }
            }
            CardGrid
            Spacer()
            Text(game.themeName).font(.title)
            
        }.padding(.horizontal).sheet(isPresented: $game.newGamepressed) {
            gameChoices
        }
    }
    
    var gameChoices: some View {
        VStack {
            ForEach(EmojiKind.allCases, id: \.self) { emoji in
                Button {
                    game.selctedNewTypeOfEmojies(emojiKind: emoji)
                } label: {
                    VStack{
                        Image(systemName: emoji.systemName).font(.title)
                        Text(emoji.rawValue)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    
    var CardGrid: some View {
        ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(game.cards) {
                CardView(card: $0, choose: game.choose)
            }.aspectRatio(2/3, contentMode: .fit)
        }.padding(5).foregroundColor(.red)
        }
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    var choose: (MemoryGame<String>.Card) -> ()
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
               
                if card.isFaceUp {
                    shape.fill()
                        .foregroundColor(.white)
                    shape.stroke(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(self.geometry(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }.onTapGesture {
                choose(card)
            }
        }
       
    }
    private func geometry(in size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(game: EmojiMemoryGame())
        EmojiMemoryGameView(game: EmojiMemoryGame()).preferredColorScheme(.dark)
    }
}
