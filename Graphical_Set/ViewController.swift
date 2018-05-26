//
//  ViewController.swift
//  Graphical_Set
//
//  Created by Yong Yang on 5/22/18.
//  Copyright © 2018 Edison Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Set_game?
    var stack_view: UIView?
    var cards_in_stack = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the game and draw a card
        game = Set_game()
        // laod the card stack view
        let frame = CGRect(x: 20, y: 20, width: self.view.frame.size.width-40, height: self.view.frame.size.height*3/4)
        stack_view = UIView(frame: frame)
        stack_view!.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.5)
        self.view.addSubview(stack_view!)
        // load first 12 cards
        for _ in 0...44{
            let card = game?.draw_a_card()
            cards_in_stack.append(card!)
        }
        // load the cards
        load_cards(cards: cards_in_stack)
    }
    
    func load_cards(cards: [Card]){
        let x_num = Int(sqrt(Double(cards.count)/0.75))
        let y_num = Int(Double(x_num)*0.75)
        
        for i in 0..<y_num{
            for j in 0..<x_num{
                let card = game?.draw_a_card()
                let frame = CGRect(x: stack_view!.bounds.minX+stack_view!.bounds.width/CGFloat(x_num)*CGFloat(j),
                                   y: stack_view!.bounds.minY+stack_view!.bounds.height/CGFloat(y_num)*CGFloat(i),
                                   width: stack_view!.bounds.width/CGFloat(x_num),
                                   height: stack_view!.bounds.height/CGFloat(y_num))
                let customView = CardView(color: card!.color, num: card!.number, shape: card!.shape, shading: card!.shading, cgrect: frame)
                customView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                stack_view!.addSubview(customView)
            }
        }
    }
}

