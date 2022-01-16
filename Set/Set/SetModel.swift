//
//  SetModel.swift
//  Set
//
//  Created by Rhea Malik on 7/6/21.
//

import SwiftUI

struct SetModel {
    private static let shadings: [Shading] = [.open, .striped, .solid]
    private static let shapes: [CardShape] = [.diamond, .rectangle, .roundedRectangle]
    private static let numbers: [Int] = [1, 2, 3]
    private static let colors: [Color] = [.red, .green, .blue]
    
    private(set) var deck: [Card]
    private(set) var shownCards: [Card]
    private(set) var selectedCards: [Int] = Array<Int>()
    private(set) var score = 0
    
    init() {
        deck = [Card]()
        for i in 0..<3 {
            for j in 0..<3 {
                for k in 0..<3 {
                    for l in 0..<3 {
                        deck.append(Card(id: 27*i + 9*j + 3*k + l, color: SetModel.colors[i], shape: SetModel.shapes[j], number: SetModel.numbers[k], shading: SetModel.shadings[l]))
                    }
                }
            }
        }
        deck.shuffle()
        shownCards = [Card]()
        for _ in 0..<12 {
            shownCards.append(deck.removeFirst())
        }
    }
    
    mutating func choose(_ c: Card?) {
        if let card = c, let cardIndex = shownCards.firstIndex(of: card) {
            // if a card was selected and we can retrieve the index
            
            if selectedCards.count == 3 {
                // if there are three selected cards
                if selectedAreAMatch() {
                    score += 1
                    // if the three are a match
                    for i in 0..<selectedCards.count {
                        shownCards[selectedCards[i]].isSelected = false // deselect all of the currently selected ones (but leave them in array)
                    }
                    print("1 shown cards: \(shownCards)")
                    print("1 selected cards: \(selectedCards)")
                    
                    if !deck.isEmpty {
                        // if there are more cards left then replace the matched ones
                        shownCards[selectedCards[0]] = deck.removeFirst() // replace the first selected card with a new card from the deck
                        shownCards[selectedCards[1]] = deck.removeFirst() // replace the second one
                        shownCards[selectedCards[2]] = deck.removeFirst() // replace the third one
                        
                        print("2 shown cards: \(shownCards)")
                        print("2 selected cards: \(selectedCards)")
                    } else {
                        // if there aren't more cards in the deck, then simply remove the matched ones
                        shownCards.remove(at: selectedCards[0]) // remove first selected one
                        shownCards.remove(at: selectedCards[1]) // remove second selected one
                        shownCards.remove(at: selectedCards[2]) // remove third selected one
                        print("3 shown cards: \(shownCards)")
                        print("3 selected cards: \(selectedCards)")
                    }
                    selectedCards = [] // empty the selected cards array
                    print("4 shown cards: \(shownCards)")
                    print("4 selected cards: \(selectedCards)")
                } else {
                    // if the three aren't a match
                    for i in 0..<selectedCards.count {
                        shownCards[selectedCards[i]].isSelected = false // deselect all the previously selected ones
                    }
                    selectedCards = [] // empty the array
                    print("5 shown cards: \(shownCards)")
                    print("5 selected cards: \(selectedCards)")
                    score -= 1
                }
            } else {
                // if there are less than three selected cards
                shownCards[cardIndex].isSelected.toggle() // select it if it isn't yet and deselect it if it's already selected
                print("6 shown cards: \(shownCards)")
                print("6 selected cards: \(selectedCards)")
                if shownCards[cardIndex].isSelected {
                    // if it's now selected
                    selectedCards.append(cardIndex) // add it to the selected array
                    print("7 shown cards: \(shownCards)")
                    print("7 selected cards: \(selectedCards)")
                } else {
                    // if it now is not selected
                    selectedCards.remove(at: selectedCards.firstIndex(of: cardIndex)!) // remove it from the selected array
                    print("8 shown cards: \(shownCards)")
                    print("8 selected cards: \(selectedCards)")
                }
            }
        }
    }
    
    mutating func addCard() {
        shownCards.append(deck.removeFirst()) // remove the top card from the deck and add it to the cards displayed on screen
    }
    
    func selectedAreAMatch() -> Bool {
        if selectedCards.count < 3 {
            // if there aren't even 3 cards selected then not possible so return false
            return false
        }
        if doWork(shownCards[selectedCards[0]].color, shownCards[selectedCards[1]].color, shownCards[selectedCards[2]].color) && // if the colors are compatible
            doWork(shownCards[selectedCards[0]].shape, shownCards[selectedCards[1]].shape, shownCards[selectedCards[2]].shape) && // if the shapes are
            doWork(shownCards[selectedCards[0]].shading, shownCards[selectedCards[1]].shading, shownCards[selectedCards[2]].shading) // if shadings are
        {
            return true
        } else {
            // if some of the colors/shapes/shadings don't match together
            return false
        }
    }
    
    func doWork<CardComponent: Equatable>(_ card1: CardComponent, _ card2: CardComponent, _ card3: CardComponent) -> Bool {
        if card1 == card2 && card1 == card3 && card2 == card3 {
            // all the same
            return true
        } else if card1 != card2 && card1 != card3 && card2 != card3 {
            // all different
            return true
        } else {
            return false
        }
    }
    
    struct Card: Identifiable, Equatable {
        let id: Int
        let color: Color
        let shape: CardShape
        let number: Int
        let shading: Shading
        var isSelected: Bool = false
    }
}
