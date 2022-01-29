//
//  SetGameModel.swift
//  SetGame
//
//  Created by Samuel Alake on 1/21/22.
//

import Foundation
import SwiftUI

struct SetGame<Content, ShadeType, FillType> where Content: Equatable & Hashable, ShadeType: Equatable & Hashable, FillType: Equatable & Hashable{
    
    private(set) var cards:[Card]
    
    private var indexOfTheOtherTwo: (Int?, Int?) {
        get{
            let selectedCardIndices = cards.indices.filter({cards[$0].isSelected})
            return selectedCardIndices.otherTwo
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue.0 || index == newValue.1)
            }
        }
    }
    
    init(cards: [Card]){
        self.cards = cards
    }
    
    func checkIfAllSatisySet(cardSet: [Card]) -> Bool{
        
        let colorSet = Set(cardSet.map({$0.color}))
        let shapeSet = Set(cardSet.map({$0.content}))
        let shadingSet = Set(cardSet.map({$0.shading}))
        let numberOfContent = Set(cardSet.map({$0.numberOfContent}))
        
        if(colorSet.count == 2){
            return false
        }else if(shapeSet.count == 2){
            return false
        }else if(shadingSet.count == 2){
            return false
        }else if(numberOfContent.count == 2){
            return false
        }else{
            return true
        }
    }
    
    private var countOfCardsSelected: Int = 0
    
    private(set) var isMatchFound: Bool = false
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
            !cards[chosenIndex].isMatched
        {
            
            if let potentialMatchOne = indexOfTheOtherTwo.0,
                let potentialMatchTwo = indexOfTheOtherTwo.1,
                !cards[chosenIndex].isSelected
               //countOfCardsSelected <= 2
            {
                
                let cardSet: [Card] = [cards[potentialMatchOne], cards[potentialMatchTwo], cards[chosenIndex]]
                //print("potential code ran")
                if checkIfAllSatisySet(cardSet: cardSet){
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchOne].isMatched = true
                    cards[potentialMatchTwo].isMatched = true
                    isMatchFound = true
                    //print("match found")
                }else{
                    isMatchFound = false
                    //print("match not found")
                }

            cards[chosenIndex].isSelected = true
            countOfCardsSelected += 1
            
            }else if(countOfCardsSelected < 2  || (countOfCardsSelected <= 2 && cards[chosenIndex].isSelected)){
                
                if(cards[chosenIndex].isSelected == false){
                    cards[chosenIndex].isSelected = true
                    countOfCardsSelected += 1
                    //print("\(countOfCardsSelected)st selection so far. Index of two face up is \(indexOfTheOtherTwo.0 ?? -1) and \(indexOfTheOtherTwo.1 ?? -1)")
                }else{
                    countOfCardsSelected -= 1
                    cards[chosenIndex].isSelected = false
                    //print("card deselected")
                }
                
                //print("count of taps is now: \(countOfCardsSelected)")
            }else{
                for index in cards.indices {
                    cards[index].isSelected = false
                }
                
                //print("reset happened")
                
                cards.indices.forEach({cards[$0].isSelected = ($0 == chosenIndex)})
                
                countOfCardsSelected = 1
                
                //print("count of taps is now: \(countOfCardsSelected)")
                
                cards.removeAll(where: {$0.isMatched})
            }
        }
        //print("\(cards)")
    }
    
    struct Card : Identifiable{
        var id = UUID()
        var content: Content
        var numberOfContent: Int
        var shading: ShadeType
        var color: FillType
        var isMatched: Bool = false
        var isFaceUp: Bool = false
        var isSelected: Bool = false
    }
    
}

extension Array{
    var otherTwo: (Element?, Element?) {
        if count == 2{
            return (first: first, second: self[1])
        }else{
            return (nil, nil)
        }
    }
}
