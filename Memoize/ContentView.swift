//
//  ContentView.swift
//  Memoize
//
//  Created by ahmad alhayek on 9/18/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 5) {
                VStack(alignment: .center, spacing: 5) {
                    Text("Score:").font(.title3)
                    Text("\(viewModel.score)").font(.title3)
                }
                
               Spacer()
    
                    Button {
                        viewModel.userPressedNewGame()
                    } label: {
                        Text("New Game").font(.title3)
                    }
            }
            CardGrid
            Spacer()
            Text(viewModel.themeName).font(.title)
            
        }.padding(.horizontal).sheet(isPresented: $viewModel.newGamepressed) {
            gameChoices
        }
    }
    
    var gameChoices: some View {
        VStack {
            ForEach(EmojiKind.allCases, id: \.self) { emoji in
                Button {
                    viewModel.selctedNewTypeOfEmojies(emojiKind: emoji)
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
            ForEach(viewModel.cards) {
                CardView(card: $0, choose: viewModel.choose)
            }.aspectRatio(2/3, contentMode: .fit)
        }.padding(5).foregroundColor(.red)
        }
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    var choose: (MemoryGame<String>.Card) -> ()
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
           
            if card.isFaceUp {
                shape.fill()
                    .foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
        ContentView(viewModel: EmojiMemoryGame()).preferredColorScheme(.dark)
    }
}
