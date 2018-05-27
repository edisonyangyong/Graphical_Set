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
        path.move(to: CGPoint(x: bounds.minX+0.4*bounds.width, y: bounds.minY+0.6*bounds.height+offset))
        path.addArc(withCenter: CGPoint(x: bounds.minX+0.4*bounds.width, y: bounds.midY+offset), radius: 0.1*bounds.height, startAngle: 0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.minX+0.6*bounds.width, y: bounds.minY+0.4*bounds.height+offset))
        path.addArc(withCenter: CGPoint(x: bounds.minX+0.6*bounds.width, y: bounds.midY+offset), radius: 0.1*bounds.height, startAngle: 1.5*CGFloat.pi, endAngle: -1.5*CGFloat.pi, clockwise: true)
        draw_line(path: path)
    }
    
    func draw_squiggle(path: UIBezierPath, offset: CGFloat){
        path.move(to: CGPoint(x: bounds.minX+0.3*bounds.width, y: bounds.minY+0.579*bounds.height+offset))
        path.addCurve(to:  CGPoint(x: bounds.minX+0.7*bounds.width, y: bounds.minY+0.421*bounds.height+offset), controlPoint1:  CGPoint(x: bounds.minX+0.4253*bounds.width, y: bounds.minY+0.162*bounds.height+offset), controlPoint2: CGPoint(x: bounds.minX+0.5535*bounds.width, y: bounds.minY+0.579*bounds.height+offset))
        path.addCurve(to:  CGPoint(x: bounds.minX+0.3*bounds.width, y: bounds.minY+0.579*bounds.height+offset), controlPoint1:  CGPoint(x: bounds.minX+0.5535*bounds.width, y: bounds.minY+0.838*bounds.height+offset), controlPoint2: CGPoint(x: bounds.minX+0.4253*bounds.width, y: bounds.minY+0.421*bounds.height+offset))
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
        if is_select{
            roundedRect?.lineWidth = bounds.width/5
             UIColor.yellow.setStroke()
        }else{
            UIColor.gray.setStroke()
        }
        roundedRect!.stroke()
        // draw the pattern
        switch self.color{
            case .red?: UIColor.red.setStroke(); UIColor.red.setFill()
            case .green?: UIColor.green.setStroke(); UIColor.green.setFill()
            case .blue?: UIColor.blue.setStroke(); UIColor.blue.setFill()
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
    
    @objc func choose_card(){
        is_select = !is_select
        setNeedsDisplay()
        setNeedsLayout()
    }
}
