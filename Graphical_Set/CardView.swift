//
//  CardView.swift
//  Graphical_Set
//
//  Created by Yong Yang on 5/22/18.
//  Copyright © 2018 Edison Yang. All rights reserved.
//

import UIKit

class CardView: UIView {
    var color : Card.Color?
    var num: Int?
    var shape: Card.Shape?
    var shading: Card.Shading?
    var offset: CGFloat?
    var path = UIBezierPath()
    
    init(color: Card.Color, num: Int, shape: Card.Shape, shading: Card.Shading, cgrect: CGRect) {
        super.init(frame: cgrect)
        self.color = color
        self.num = num
        self.shape = shape
        self.shading = shading
        if num == 2{
            offset = 0.187*bounds.height
        } else if num == 3{
            offset = 0.275*bounds.height
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func draw_diamond(){
        if self.num == 1 || self.num == 3{
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.163*bounds.width, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY+0.414*bounds.height))
            path.addLine(to: CGPoint(x: bounds.minX+0.837*bounds.width, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY+0.596*bounds.height))
            draw_path()
        }
        if self.num == 2 || self.num == 3{
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.163*bounds.width, y: bounds.midY-offset!))
            path.addLine(to: CGPoint(x: bounds.midX, y: (bounds.minY+0.414*bounds.height)-offset!))
            path.addLine(to: CGPoint(x: bounds.minX+0.837*bounds.width, y: bounds.midY-offset!))
            path.addLine(to: CGPoint(x: bounds.midX, y: (bounds.minY+0.596*bounds.height)-offset!))
           draw_path()
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.163*bounds.width, y: bounds.midY+offset!))
            path.addLine(to: CGPoint(x: bounds.midX, y: (bounds.minY+0.414*bounds.height)+offset!))
            path.addLine(to: CGPoint(x: bounds.minX+0.837*bounds.width, y: bounds.midY+offset!))
            path.addLine(to: CGPoint(x: bounds.midX, y: (bounds.minY+0.596*bounds.height)+offset!))
           draw_path()
        }
    }
    
    func draw_path(){
        path.close()
        path.lineWidth = 5.0
        path.stroke()
        path.fill()
    }
    
    func draw_oval(){
        if self.num == 1 || self.num == 3{
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.267*bounds.width, y: bounds.minY+0.6*bounds.height))
            path.addArc(withCenter: CGPoint(x: bounds.minX+0.267*bounds.width, y: bounds.midY), radius: 0.1*bounds.height, startAngle: 0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
            path.addLine(to: CGPoint(x: bounds.minX+0.681*bounds.width, y: bounds.minY+0.4*bounds.height))
            path.addArc(withCenter: CGPoint(x: bounds.minX+0.681*bounds.width, y: bounds.midY), radius: 0.1*bounds.height, startAngle: 1.5*CGFloat.pi, endAngle: -1.5*CGFloat.pi, clockwise: true)
            draw_path()
        }
        if self.num == 2 || self.num == 3{
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.267*bounds.width, y: bounds.minY+0.6*bounds.height-offset!))
            path.addArc(withCenter: CGPoint(x: bounds.minX+0.267*bounds.width, y: bounds.midY-offset!), radius: 0.1*bounds.height, startAngle: 0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
            path.addLine(to: CGPoint(x: bounds.minX+0.681*bounds.width, y: bounds.minY+0.4*bounds.height-offset!))
            path.addArc(withCenter: CGPoint(x: bounds.minX+0.681*bounds.width, y: bounds.midY-offset!), radius: 0.1*bounds.height, startAngle: 1.5*CGFloat.pi, endAngle: -1.5*CGFloat.pi, clockwise: true)
            draw_path()
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.267*bounds.width, y: bounds.minY+0.6*bounds.height+offset!))
            path.addArc(withCenter: CGPoint(x: bounds.minX+0.267*bounds.width, y: bounds.midY+offset!), radius: 0.1*bounds.height, startAngle: 0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
            path.addLine(to: CGPoint(x: bounds.minX+0.681*bounds.width, y: bounds.minY+0.4*bounds.height+offset!))
            path.addArc(withCenter: CGPoint(x: bounds.minX+0.681*bounds.width, y: bounds.midY+offset!), radius: 0.1*bounds.height, startAngle: 1.5*CGFloat.pi, endAngle: -1.5*CGFloat.pi, clockwise: true)
            draw_path()
        }
    }
    
    func draw_squiggle(){
        if self.num == 1 || self.num == 3{
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.1815*bounds.width, y: bounds.minY+0.579*bounds.height))
            path.addCurve(to:  CGPoint(x: bounds.minX+0.815*bounds.width, y: bounds.minY+0.421*bounds.height), controlPoint1:  CGPoint(x: bounds.minX+0.305*bounds.width, y: bounds.minY+0.162*bounds.height), controlPoint2: CGPoint(x: bounds.minX+0.672*bounds.width, y: bounds.minY+0.579*bounds.height))
            path.addCurve(to:  CGPoint(x: bounds.minX+0.1815*bounds.width, y: bounds.minY+0.579*bounds.height), controlPoint1:  CGPoint(x: bounds.minX+0.695*bounds.width, y: bounds.minY+0.838*bounds.height), controlPoint2: CGPoint(x: bounds.minX+0.328*bounds.width, y: bounds.minY+0.421*bounds.height))
            draw_path()
        }
        if self.num == 2 || self.num == 3{
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.1815*bounds.width, y: bounds.minY+0.579*bounds.height-offset!))
            path.addCurve(to:  CGPoint(x: bounds.minX+0.815*bounds.width, y: bounds.minY+0.421*bounds.height-offset!), controlPoint1:  CGPoint(x: bounds.minX+0.305*bounds.width, y: bounds.minY+0.162*bounds.height-offset!), controlPoint2: CGPoint(x: bounds.minX+0.672*bounds.width, y: bounds.minY+0.579*bounds.height-offset!))
            path.addCurve(to:  CGPoint(x: bounds.minX+0.1815*bounds.width, y: bounds.minY+0.579*bounds.height-offset!), controlPoint1:  CGPoint(x: bounds.minX+0.695*bounds.width, y: bounds.minY+0.838*bounds.height-offset!), controlPoint2: CGPoint(x: bounds.minX+0.328*bounds.width, y: bounds.minY+0.421*bounds.height-offset!))
            draw_path()
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX+0.1815*bounds.width, y: bounds.minY+0.579*bounds.height+offset!))
            path.addCurve(to:  CGPoint(x: bounds.minX+0.815*bounds.width, y: bounds.minY+0.421*bounds.height+offset!), controlPoint1:  CGPoint(x: bounds.minX+0.305*bounds.width, y: bounds.minY+0.162*bounds.height+offset!), controlPoint2: CGPoint(x: bounds.minX+0.672*bounds.width, y: bounds.minY+0.579*bounds.height+offset!))
            path.addCurve(to:  CGPoint(x: bounds.minX+0.1815*bounds.width, y: bounds.minY+0.579*bounds.height+offset!), controlPoint1:  CGPoint(x: bounds.minX+0.695*bounds.width, y: bounds.minY+0.838*bounds.height+offset!), controlPoint2: CGPoint(x: bounds.minX+0.328*bounds.width, y: bounds.minY+0.421*bounds.height+offset!))
            draw_path()
        }
    }
    
    func draw_lines(){
        for i in 0...50{
            let line = UIBezierPath()
            line.move(to: CGPoint(x: bounds.minX+bounds.width/50*CGFloat(i), y: bounds.minY))
            line.addLine(to: CGPoint(x: bounds.minX+bounds.width/50*CGFloat(i), y: bounds.maxY))
            line.lineWidth = 5.0
            line.stroke()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // draw the rounded rect
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        // draw the pattern
        switch self.color{
            case .red?: UIColor.red.setStroke(); UIColor.red.setFill()
            case .green?: UIColor.green.setStroke(); UIColor.green.setFill()
            case .blue?: UIColor.blue.setStroke(); UIColor.blue.setFill()
            default: break
        }
        switch self.shading{
        case .strip?:UIColor.white.setFill(); draw_lines()
            case .fill?: break
            case .outline?: UIColor.white.setFill()
            default: break
        }
        switch self.shape{
            case .squiggle?: draw_squiggle()
            case .diamond?: draw_diamond()
            case .oval?: draw_oval()
            default: break
        }
    }
}
