//
//  Set_Game.swift
//  Graphical_Set
//
//  Created by Yong Yang on 5/22/18.
//  Copyright © 2018 Edison Yang. All rights reserved.
//

import Foundation

struct Set_game{
    var score = 0
    var cards = [Card]()
    init(){
        for color in Card.Color.all{
            for shading in Card.Shading.all{
                for shape in Card.Shape.all{
                    for num in 1...3{
                        cards.append(Card(shape: shape, number:num, color:color, shading:shading))
                    }
                }
            }
        }
    }
    
    mutating func set_checking(is_cheated: Bool, card1: Card, card2: Card, card3: Card) -> Bool{
        let num_checking_set: Set = [card1.number, card2.number, card3.number]
        let color_checking_set: Set = [card1.color, card2.color, card3.color]
        let shape_checking_set: Set = [card1.shape, card2.shape, card3.shape]
        let shading_checking_set: Set = [card1.shading, card2.shading, card3.shading]
        if num_checking_set.count != 2, color_checking_set.count != 2, shape_checking_set.count != 2, shading_checking_set.count != 2{
            if !is_cheated { score += 3 }
            return true
        }
        else{
            if !is_cheated { score -= 1 }
            return false
        }
    }
    
    func return_card_index(card: Card, cards:[Card])->Int{
        return cards.index(where: {($0.color, $0.number, $0.shape, $0.shading) == (card.color, card.number, card.shape, card.shading)})!
    }
    
    mutating func draw_a_card() -> Card?{
        if cards.count != 0{
            return self.cards.remove(at: cards.count.arc4random)
        }else{
            return nil
        }
    }
}

extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
