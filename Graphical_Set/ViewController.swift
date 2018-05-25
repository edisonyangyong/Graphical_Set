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
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the game and draw a card
        game = Set_game()
        deal_a_card()
    }
    
    @objc func deal_a_card(){
        card = game?.draw_a_card()
        print(card!.color, card!.number, card!.shading, card!.shape)
        
        // draw a card
        let frame = CGRect(x: 100, y: 100, width: 100, height: 150)
        let customView = CardView(color: card!.color, num: card!.number, shape: card!.shape, shading: card!.shading, cgrect: frame)
        customView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(customView)
        
        // add the tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(deal_a_card))
        customView.addGestureRecognizer(tap)
    }
}

