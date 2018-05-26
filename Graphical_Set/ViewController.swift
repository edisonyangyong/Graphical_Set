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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the game and draw a card
        game = Set_game()
        // laod the card stack view
        let frame = CGRect(x: 20, y: 20, width: self.view.frame.size.width-40, height: self.view.frame.size.height*3/4)
        stack_view = UIView(frame: frame)
        stack_view!.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.5)
        self.view.addSubview(stack_view!)
        deal_a_card()
    }
    
    @objc func deal_a_card(){
        if let card = game?.draw_a_card(){
            print(card.color, card.number, card.shading, card.shape)
            
            // add a card view
            let frame = CGRect(x: 10, y: stack_view!.bounds.minY, width: stack_view!.bounds.width/4, height: stack_view!.bounds.height/4)
            let customView = CardView(color: card.color, num: card.number, shape: card.shape, shading: card.shading, cgrect: frame)
            customView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            stack_view!.addSubview(customView)
            
            // add the tap gesture
            let tap = UITapGestureRecognizer(target: self, action: #selector(deal_a_card))
            customView.addGestureRecognizer(tap)
        }
    }
}

