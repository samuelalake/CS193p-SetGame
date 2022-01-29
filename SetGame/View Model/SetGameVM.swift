//
//  SetGameVM.swift
//  SetGame
//
//  Created by Samuel Alake on 1/21/22.
//

import Foundation
import SwiftUI

class SetGameVM: ObservableObject{
    typealias Card = SetGame<CardShape, CardStyle, CardColors>.Card
    
    static private var cardColors : [Color] = [.cyan, .indigo, .red]
    //for (_, value) in cardColors.enumerated()
    
    @State var numOfItemsToShow: Int = 12
    
    @Published private var model = SetGame(cards: createSetGame())
    
    private static func createSetGame() -> [Card]{
        var newSet: [Card] = []
        
        for shape in CardShape.allCases{
            for style in CardStyle.allCases{
                for color in CardColors.allCases{
                    for index in 1...3{
                        let newCard = Card(content: shape, numberOfContent: index, shading: style, color: color)
                        newSet.append(newCard)
                    }
                }
            }
        }
        
        //print("Hello")
        //print(newSet.count)
        newSet.shuffle()
        return newSet
    }
    
    var cards: [Card]{
        return model.cards
    }
    
    var isMatchFound: Bool{
        return model.isMatchFound
    }
    
    //MARK: - Intent
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func dealThree(){
        numOfItemsToShow += 3
    }
    
    func newGame(){
        model = SetGame(cards: SetGameVM.createSetGame())
    }
    
}

enum CardShape : CaseIterable, Equatable{
    case rectangle, capsule, diamond
}

enum CardStyle : CaseIterable, Equatable{
    case shaded, stroked, striped
}

enum CardColors: CaseIterable, Equatable{
    case cyan, indigo, red
    
    var mainColor: Color{
        switch self{
        case .cyan:
            return .cyan
        case .indigo:
            return .indigo
        case .red:
            return .red
        }
    }
}
