//
//  Diamond.swift
//  SetGame
//
//  Created by Samuel Alake on 1/21/22.
//

import SwiftUI

struct Diamond : InsettableShape {
    var insetAmount = 0.0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        return path
    }
}

//other shape related code

struct AnyShape: Shape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }
    
    private let _path: (CGRect) -> Path
}

//SetGameVM.CardShape //SetGame<Content, FillType>.Card.shading
func getShape(cardShape: CardShape) -> some Shape {
    switch cardShape {
    case .capsule:
        return AnyShape(Capsule())
    case .rectangle:
        return AnyShape(Rectangle())
    case .diamond:
        return AnyShape(Diamond())
    }
}
