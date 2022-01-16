//
//  SetViewModel.swift
//  Set
//
//  Created by Rhea Malik on 7/6/21.
//

import Foundation

class SetViewModel: ObservableObject {
    @Published private(set) var model = SetModel()
    var score: Int {
        return model.score
    }
    
    var selectedCards: [Int] {
        return model.selectedCards
    }
    
    var shownCards: [SetModel.Card] {
        return model.shownCards
    }
    
    func choose(_ card: SetModel.Card?) {
        model.choose(card)
    }
    
    func addThreeCards() {
        for _ in 0..<3 {
            model.addCard()
        }
    }
    
    func newGame() {
        model = SetModel()
    }
    
    func selectedAreAMatch() -> Bool {
        return model.selectedAreAMatch()
    }
}
