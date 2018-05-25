//
//  Card.swift
//  Graphical_Set
//
//  Created by Yong Yang on 5/22/18.
//  Copyright © 2018 Edison Yang. All rights reserved.
//

import Foundation

struct Card{
    var shape: Shape
    var number: Int
    var color: Color
    var shading: Shading
    var is_selected = false
    
    enum Shape {
        case squiggle
        case diamond
        case oval
        static var all = [Shape.squiggle, .diamond, .oval]
    }
    
    enum Shading {
        case strip
        case fill
        case outline
        static var all = [Shading.strip, .fill, .outline]
    }
    
    enum Color{
        case red
        case blue
        case green
        static var all = [Color.red, .blue, .green]
    }
}
