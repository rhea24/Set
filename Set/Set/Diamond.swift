//
//  Diamond.swift
//  Set
//
//  Created by Rhea Malik on 7/11/21.
//

import SwiftUI

struct Diamond: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var diamond = self
        diamond.insetAmount += amount
        return diamond
    }
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.maxX, y: rect.midY)
        var p = Path()
        
        
        p.move(to: start)
        p.addArc(center: start, radius: 0, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 120), clockwise: false)
        
        let bottom = CGPoint(x: rect.midX, y: rect.minY)
        p.addLine(to: bottom)
        p.addArc(center: bottom, radius: 0, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 120), clockwise: false)
        
        let left = CGPoint(x: rect.minX, y: rect.midY)
        p.addLine(to: left)
        p.addArc(center: left, radius: 0, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 120), clockwise: false)
        
        let top = CGPoint(x: rect.midX, y: rect.maxY)
        p.addLine(to: top)
        p.addArc(center: top, radius: 0, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 120), clockwise: false)
        
        p.addLine(to: start)
        return p
    }
    
}

extension Diamond {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: CGFloat = 1) -> some View {
        self
            .strokeBorder(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}
