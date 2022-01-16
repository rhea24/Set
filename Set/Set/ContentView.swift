//
//  ContentView.swift
//  Set
//
//  Created by Rhea Malik on 7/6/21.
//

import SwiftUI
typealias Card = SetModel.Card

struct ContentView: View {
    @ObservedObject var game = SetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Score: \(game.score)")
                    .font(.largeTitle)
            }
            AspectVGrid(items: game.shownCards, aspectRatio: 1.5, content: { card in
                CardView(card: card)
                    .padding()
                    .onTapGesture {
                        game.choose(card)
                    }
            })
            HStack {
                Spacer()
                Button(action: {
                    if game.model.deck.isEmpty || game.model.shownCards.count == 21 {
                        self.disabled(true)
                    } else if game.selectedAreAMatch() {
                        game.choose(game.model.shownCards[game.model.selectedCards.last!])
                    } else {
                        game.addThreeCards()
                    }
                }, label: {
                    Text("Deal 3 More Cards")
                })
                Spacer()
                Button(action: {
                    game.newGame()
                }, label: {
                    Text("New Game")
                })
                Spacer()
            }
        }
    }
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            
            if card.isSelected {
                switch card.shape {
                case CardShape.diamond:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .strokeBorder(lineWidth: 2, antialiased: true)
                            .foregroundColor(.blue)
                            
                        HStack {
                            ForEach(0..<card.number, id: \.self) { _ in
                                switch card.shading {
                                case Shading.open:
                                    Diamond()
                                        .strokeBorder(lineWidth: 2, antialiased: true)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                        .foregroundColor(card.color)
                                case Shading.solid:
                                    Diamond()
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .foregroundColor(card.color)
                                        .padding(10)
                                case Shading.striped:
                                    Diamond()
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .foregroundColor(card.color)
                                        .opacity(0.2)
                                        .padding(10)
                                }
                            }
                        }
                    }
                case CardShape.rectangle:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .strokeBorder(lineWidth: 2, antialiased: true)
                            .foregroundColor(.blue)
                        HStack {
                            ForEach(0..<card.number, id: \.self) { _ in
                                switch card.shading {
                                case Shading.open:
                                    Rectangle()
                                        .strokeBorder(lineWidth: 2, antialiased: true)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .foregroundColor(card.color)
                                        .padding(10)
                                case Shading.solid:
                                    Rectangle()
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                case Shading.striped:
                                    Rectangle()
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .opacity(0.2)
                                        .padding(10)
                                }
                            }
                        }
                    }
                case CardShape.roundedRectangle:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .strokeBorder(lineWidth: 2, antialiased: true)
                            .foregroundColor(.blue)
                        HStack {
                            ForEach(0..<card.number, id: \.self) { _ in
                                switch card.shading {
                                case Shading.open:
                                    RoundedRectangle(cornerRadius: 20)
                                        .strokeBorder(lineWidth: 2, antialiased: true)
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                case Shading.solid:
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                case Shading.striped:
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(card.color)
                                        .opacity(0.2)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                }
                            }
                        }
                    }
                }
            } else {
                switch card.shape {
                case CardShape.diamond:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .strokeBorder(lineWidth: 2, antialiased: true)
                        HStack {
                            ForEach(0..<card.number, id: \.self) { _ in
                                switch card.shading {
                                case Shading.open:
                                    Diamond()
                                        .strokeBorder(lineWidth: 2, antialiased: true)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                        .foregroundColor(card.color)
                                case Shading.solid:
                                    Diamond()
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .foregroundColor(card.color)
                                        .padding(10)
                                case Shading.striped:
                                    Diamond()
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .foregroundColor(card.color)
                                        .opacity(0.2)
                                        .padding(10)
                                }
                            }
                        }
                    }
                case CardShape.rectangle:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .strokeBorder(lineWidth: 2, antialiased: true)
                        HStack {
                            ForEach(0..<card.number, id: \.self) { _ in
                                switch card.shading {
                                case Shading.open:
                                    Rectangle()
                                        .strokeBorder(lineWidth: 2, antialiased: true)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .foregroundColor(card.color)
                                        .padding(10)
                                case Shading.solid:
                                    Rectangle()
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                case Shading.striped:
                                    Rectangle()
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .opacity(0.2)
                                        .padding(10)
                                }
                            }
                        }
                    }
                case CardShape.roundedRectangle:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .strokeBorder(lineWidth: 2, antialiased: true)
                        
                        HStack {
                            ForEach(0..<card.number, id: \.self) { _ in
                                switch card.shading {
                                case Shading.open:
                                    RoundedRectangle(cornerRadius: 20)
                                        .strokeBorder(lineWidth: 2, antialiased: true)
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                case Shading.solid:
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .padding(10)
                                case Shading.striped:
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(card.color)
                                        .aspectRatio(2/5, contentMode: .fit)
                                        .opacity(0.2)
                                        .padding(10)
                                }
                            }
                        }
                    }
                }
            }
        })
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
