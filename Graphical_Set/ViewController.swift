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
    var cards_dictionary = [Card:CardView]()
    var cards_is_selected = [Card]()
    
    // new game button
    @IBAction func new_game(_ sender: UIButton) {
         game = Set_game()
        // clear all the subviews
        self.stack_view!.subviews.forEach({ $0.removeFromSuperview() })
        cards_in_stack = []
        for _ in 0...11{
            let card = game?.draw_a_card()
            cards_in_stack.append(card!)
        }
        // load the cards
        load_cards(cards: cards_in_stack)
    }
    
    // deal button
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
    
    @IBAction func cheat(_ sender: UIButton) {
        for card in cards_is_selected{
            cards_dictionary[card]!.select_and_deselect_the_card()
        }
        for (_, card_view) in cards_dictionary{
            if card_view.is_match != nil{
                card_view.match_card_and_redraw(match: nil)
                card_view.select_and_deselect_the_card()
            }
        }
        print(cheat_check())
    }
    
    func cheat_check() -> String{
        for i in 0..<cards_in_stack.count{
            for j in (i+1)..<cards_in_stack.count{
                for k in (j+1)..<cards_in_stack.count{
                    if game!.set_checking(is_cheated: true, card1: cards_in_stack[i], card2: cards_in_stack[j], card3: cards_in_stack[k]){
                        cards_dictionary[cards_in_stack[i]]?.match_card_and_redraw(match: true)
                        cards_dictionary[cards_in_stack[j]]?.match_card_and_redraw(match: true)
                        cards_dictionary[cards_in_stack[k]]?.match_card_and_redraw(match: true)
                        return "found"
                    }
                }
            }
        }
        return "not found"
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
                    cards_dictionary[cards[index]] = customView
                    index += 1
                    // add gesture
                    let tap = UITapGestureRecognizer(target: customView, action: #selector(customView.select_and_deselect_the_card))
                    tap.addTarget(self, action: #selector(tapped))
                    customView.addGestureRecognizer(tap)
                    // 1) call select_and_deselect_the_card; 2) call tapped; 3) call redraw
                }
            }
        }
    }
    
    // being called why any card view was tapped
    @objc func tapped(){
        for (card, card_view) in cards_dictionary{
            if card_view.is_select && card_view.is_match == nil{
                var flag = false
                for c in cards_is_selected{
                    if c == card{
                        flag = true
                    }
                }
                if !flag{
                     cards_is_selected.append(card)
                }
            }else if !card_view.is_select && card_view.is_match == nil{
                for c in cards_is_selected{
                    if c == card{
                        cards_is_selected.remove(at: game!.return_card_index(card: card, cards: cards_is_selected))
                    }
                }
            }
        }
        if cards_is_selected.count == 3 {
            if game!.set_checking(is_cheated: false, card1: cards_is_selected[0], card2: cards_is_selected[1], card3: cards_is_selected[2]){
                set_match_to(bool: true)
            }else{
                set_match_to(bool: false)
            }
        }
        if cards_is_selected.count == 4{
            set_match_to(bool: nil)
            for _ in 0...2{
                cards_dictionary[cards_is_selected[0]]!.select_and_deselect_the_card()
                cards_is_selected.remove(at: 0)
            }
        }
    }
    
    func set_match_to(bool: Bool?){
        for i in 0...2{
             cards_dictionary[cards_is_selected[i]]!.match_card_and_redraw(match: bool)
        }
    }
}
