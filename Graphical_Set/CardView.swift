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
    var is_select = false
    var is_match: Bool?
    var roundedRect: UIBezierPath?
    
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
    
    func draw_pattern(){
        let path1 = UIBezierPath()
        let path2 = UIBezierPath()
        let path3 = UIBezierPath()
        switch self.shape{
        case .squiggle?:if self.num == 1 || self.num == 3{
                            draw_squiggle(path: path1, offset: 0 )
                        };
                        if self.num == 2 || self.num == 3{
                            draw_squiggle(path: path2, offset: offset!)
                            draw_squiggle(path: path3, offset: -offset!)
                        }
        case .diamond?: if self.num == 1 || self.num == 3{
                            draw_diamond(path: path1, offset: 0 )
                        };
                        if self.num == 2 || self.num == 3{
                            draw_diamond(path: path2, offset: offset!)
                            draw_diamond(path: path3, offset: -offset!)
                        }
        case .oval?:    if self.num == 1 || self.num == 3{
                            draw_oval(path: path1, offset: 0 )
                        };
                        if self.num == 2 || self.num == 3{
                            draw_oval(path: path2, offset: offset!)
                            draw_oval(path: path3, offset: -offset!)
                        }
        default: break
        }
    }
    
    func draw_diamond(path: UIBezierPath, offset: CGFloat){
        path.move(to: CGPoint(x: bounds.minX+0.3*bounds.width, y: bounds.midY+offset))
        path.addLine(to: CGPoint(x: bounds.midX, y: (bounds.minY+0.414*bounds.height)+offset))
        path.addLine(to: CGPoint(x: bounds.minX+0.7*bounds.width, y: bounds.midY+offset))
        path.addLine(to: CGPoint(x: bounds.midX, y: (bounds.minY+0.596*bounds.height)+offset))
        draw_line(path:path)
    }
    
    func draw_oval(path: UIBezierPath, offset: CGFloat){
        path.move(to: CGPoint(x: bounds.minX+0.4*bounds.width, y: bounds.minY+0.57*bounds.height+offset))
        path.addArc(withCenter: CGPoint(x: bounds.minX+0.4*bounds.width, y: bounds.midY+offset), radius: 0.07*bounds.height, startAngle: 0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.minX+0.6*bounds.width, y: bounds.minY+0.43*bounds.height+offset))
        path.addArc(withCenter: CGPoint(x: bounds.minX+0.6*bounds.width, y: bounds.midY+offset), radius: 0.07*bounds.height, startAngle: 1.5*CGFloat.pi, endAngle: -1.5*CGFloat.pi, clockwise: true)
        draw_line(path: path)
    }
    
    func draw_squiggle(path: UIBezierPath, offset: CGFloat){
        path.move(to: CGPoint(x: bounds.minX+0.3*bounds.width, y: bounds.minY+0.5*bounds.height+offset))
        path.addCurve(to:  CGPoint(x: bounds.minX+0.7*bounds.width, y: bounds.minY+0.421*bounds.height+offset), controlPoint1:  CGPoint(x: bounds.minX+0.4253*bounds.width, y: bounds.minY+0.25*bounds.height+offset), controlPoint2: CGPoint(x: bounds.minX+0.5535*bounds.width, y: bounds.minY+0.5*bounds.height+offset))
        path.addCurve(to:  CGPoint(x: bounds.minX+0.3*bounds.width, y: bounds.minY+0.5*bounds.height+offset), controlPoint1:  CGPoint(x: bounds.minX+0.5535*bounds.width, y: bounds.minY+0.7*bounds.height+offset), controlPoint2: CGPoint(x: bounds.minX+0.4253*bounds.width, y: bounds.minY+0.421*bounds.height+offset))
        draw_line(path: path)
    }
    
    func draw_line(path: UIBezierPath){
        path.close()
        path.lineWidth = 5.0
        path.stroke()
        path.fill()
        if self.shading == .strip{
            let context = UIGraphicsGetCurrentContext()!
            context.saveGState()
            path.addClip()
            for i in 0...20{
                let line = UIBezierPath()
                line.move(to: CGPoint(x: bounds.minX+bounds.width/20*CGFloat(i), y: bounds.minY))
                line.addLine(to: CGPoint(x: bounds.minX+bounds.width/20*CGFloat(i), y: bounds.maxY))
                line.lineWidth = 1.0
                line.stroke()
            }
            context.restoreGState()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // draw the rounded card bound
        roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width/5)
        roundedRect!.addClip()
        UIColor.white.setFill()
        roundedRect!.fill()
        // draw the stroke
        if is_match == true{
            roundedRect?.lineWidth = bounds.width/7
            UIColor(red: 91/255.0, green: 201/255.0, blue: 53/255.0, alpha: 1).setStroke()
        }else if is_match == false{
            roundedRect?.lineWidth = bounds.width/7
            UIColor(red: 234/255.0, green: 49/255.0, blue: 44/255.0, alpha: 1).setStroke()
        }else{
            if is_select{
                roundedRect?.lineWidth = bounds.width/7
                UIColor(red: 250/255.0, green: 212/255.0, blue: 77/255.0, alpha: 1).setStroke()
            }else{
                roundedRect?.lineWidth = bounds.width/50
                UIColor.gray.setStroke()
            }
        }
        roundedRect!.stroke()
        // draw the pattern
        switch self.color{
        case .red?: UIColor(red: 234/255.0, green: 49/255.0, blue: 44/255.0, alpha: 1).setFill();
                    UIColor(red: 234/255.0, green: 49/255.0, blue: 44/255.0, alpha: 1).setStroke()
            case .green?: UIColor(red: 91/255.0, green: 201/255.0, blue: 53/255.0, alpha: 1).setFill();
                         UIColor(red: 91/255.0, green: 201/255.0, blue: 53/255.0, alpha: 1).setStroke()
            case .blue?: UIColor(red: 51/255.0, green: 125/255.0, blue: 246/255.0, alpha: 1).setFill();
                     UIColor(red: 51/255.0, green: 125/255.0, blue: 246/255.0, alpha: 1).setStroke()
            default: break
        }
        switch self.shading{
        case .strip?:UIColor.white.setFill();
            case .fill?: break
            case .outline?: UIColor.white.setFill()
            default: break
        }
        draw_pattern()
    }
    
    @objc func select_and_deselect_the_card(){
        if is_match == nil{
            is_select = !is_select
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
}
