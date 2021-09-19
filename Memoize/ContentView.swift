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
            HStack {
                Spacer()
                Text("Memorize!").font(.largeTitle).bold()
                    .padding(.leading).frame(alignment: .center)
                Button {
                    
                } label: {
                    Text("New Game")
                }
            }
            CardGrid
            Spacer()
        }.padding(.horizontal)
    }
    
//    var tabBar: some View {
//        HStack {
//            ForEach(EmojiKind.allCases, id: \.self) { emoji in
//                Button {
////                    currentEmojis = emoji
////                    isEmojiSheetPresent = !isEmojiSheetPresent
////                    emojiCount = Int.random(in: 8..<currentEmojis.emojis.count)
//                } label: {
//                    VStack{
//                        Image(systemName: emoji.systemName).font(.title)
//                        Text(emoji.rawValue)
//                    }
//                    .padding(.horizontal)
//                }
//            }
//        }
//    }
    
    
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
