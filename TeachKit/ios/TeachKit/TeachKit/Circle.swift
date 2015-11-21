//
//  Dimension.swift
//  
//
//  Created by Golak Sarangi on 11/14/15.
//
//

import UIKit


class CircleView: UIView {
    var radius : Double?
    var circumference : Double?
    var pixelRadius : Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func normalize () {
        if (radius != nil) {
            circumference = radius! * 2 * M_PI
        } else if (circumference != nil) {
            radius = circumference! / (2 * M_PI)
        }
    }
    
    override func drawRect(rect: CGRect) {
        // Get the Graphics Context
        let context = UIGraphicsGetCurrentContext();
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 5.0);
        
        // Set the circle outerline-colour
        UIColor.redColor().set()
        
        pixelRadius = Int((self.superview!.frame.size.width - 40) / 2)

        // Create Circle
        CGContextAddArc(context, (self.superview!.frame.size.width)/2, self.superview!.frame.size.height/2, CGFloat(pixelRadius!), 0.0, CGFloat(M_PI * 2.0), 1)
        
        // Draw
        CGContextStrokePath(context);
    }
    
    func getScale() -> Double{
        return Double(pixelRadius!) / radius!
    }
    
    func getXYfromDistance(distance: Double) -> (CGFloat, CGFloat) {
        let ctxDistance = ((distance * 1000) % (circumference! * 1000)) / 1000;
        let angle = (ctxDistance / circumference!) * 360 * (M_PI/180);
        print("Angle:\(angle)")
        let x = CGFloat(Double(pixelRadius!) * cos(angle))
        let y = CGFloat(Double(pixelRadius!) * sin(angle))
        
        print("x:\(x), y: \(y)")
        
        let centerx = self.superview!.frame.size.width/2
        let centery = self.superview!.frame.size.height/2
        
        return (centerx + x , centery + y)
        
    }
    
}