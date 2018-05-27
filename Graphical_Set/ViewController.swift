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
    
    @IBAction func deal(_ sender: UIButton) {
        if game!.cards.count >= 2{
            for _ in 0...2{
                let card = game?.draw_a_card()
                cards_in_stack.append(card!)
            }
            // load the cards
            load_cards(cards: cards_in_stack)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the game and draw a card
        game = Set_game()
        // laod the card stack view
        let frame = CGRect(x: 20, y: 20, width: self.view.frame.size.width-40, height: self.view.frame.size.height*3/4)
        stack_view = UIView(frame: frame)
        stack_view!.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(stack_view!)
        // load first 12 cards
        for _ in 0...11{
            let card = game?.draw_a_card()
            cards_in_stack.append(card!)
        }
        // load the cards
        load_cards(cards: cards_in_stack)
    }
    
    // given all the cards on the desk and re-load them in the stack view
    func load_cards(cards: [Card]){
        // clear all the subviews
        self.stack_view!.subviews.forEach({ $0.removeFromSuperview() })
        var x_num = 0
        var y_num = 0
        var index = 0
        let mid = Int(sqrt(Double(cards.count)))
        if mid*mid == cards.count{
            x_num = mid
            y_num = mid
        }else {
            x_num = mid
            y_num = mid+1
            if x_num * y_num < cards.count{
                x_num = mid + 1
            }
        }
        for i in 0..<y_num{
            for j in 0..<x_num{
                if index < cards.count{
                    let frame = CGRect(x: stack_view!.bounds.minX+stack_view!.bounds.width/CGFloat(x_num)*CGFloat(j),
                                       y: stack_view!.bounds.minY+stack_view!.bounds.height/CGFloat(y_num)*CGFloat(i),
                                       width: stack_view!.bounds.width/CGFloat(x_num),
                                       height: stack_view!.bounds.height/CGFloat(y_num))
                    let customView = CardView(color: cards[index].color, num: cards[index].number, shape: cards[index].shape, shading: cards[index].shading, cgrect: frame)
                    customView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                    stack_view!.addSubview(customView)
                    index += 1
                    // add gesture
                    let tap = UITapGestureRecognizer(target: customView, action: #selector(customView.choose_card))
                    customView.addGestureRecognizer(tap)
                }
            }
        }
    }
}
