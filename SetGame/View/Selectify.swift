//
//  Selectify.swift
//  SetGame
//
//  Created by Samuel Alake on 1/25/22.
//

import SwiftUI

struct Selectify: ViewModifier {
    var isSelected: Bool
    
    func body(content: Content) -> some View {
        
        
        content.background(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                            .strokeBorder(lineWidth: isSelected ? DrawingConstants.lineWidth: 0)
                            .background(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(isSelected ? Color(UIColor.systemGray6) : Color(UIColor.systemGray6)))
                            .shadow(color: isSelected ? Color.black.opacity(0.1) : Color.clear, radius: 20, x: 1, y: 1)
        )

        
            
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let shadowOpacity: Double = 1
    }
    
}

extension View{
    func selectify(isSelected: Bool) -> some View{
        self.modifier(Selectify(isSelected: isSelected))
    }
}
//struct Selectify_Previews: PreviewProvider {
//    static var previews: some View {
//        Selectify()
//    }
//}
