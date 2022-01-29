//
//  ContentView.swift
//  SetGame
//
//  Created by Samuel Alake on 1/21/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGameVM
    @State private var numOfItemsToShow: Int = 12
    
    var body: some View {
        
        VStack {
            
            VStack{
                Text("Select three cards that form a Set").font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding([.horizontal, .top])
            }
            
            AspectVGrid(items: setGame.cards, numOfItemsToShow: numOfItemsToShow, aspectRatio: 2/3){ card in
                SetGameCard(card: card)
                    .onTapGesture {
                        withAnimation{
                            setGame.choose(card)
                        }
                    }
            }
            .foregroundColor(.blue)
            .padding(.horizontal)
            
            
            if(setGame.isMatchFound) {
                HStack{
                    Text("🎉 SET").font(.title3).bold().padding()
                        .foregroundColor(Color(UIColor.label))
                }
            }
            
            HStack{
                Button("Deal 3 More Cards", action: {numOfItemsToShow += 3})
                Spacer()
                Button("New Game", action: setGame.newGame)
            }.padding(.horizontal)
        }
    }
}

struct SetGameCard: View{
    let card: SetGameVM.Card
    
    var body: some View{
        GeometryReader{ geometry in
            VStack(alignment: .center) {
                VStack{
                    
                    ForEach(0..<card.numberOfContent, id: \.self){_ in
                        
                    getShape(cardShape: card.content)
                            .stroke(card.color.mainColor, lineWidth: 4)
                            .background(getShape(cardShape: card.content).fill(card.shading != CardStyle.stroked ? card.color.mainColor : Color.clear))
                            .opacity(card.shading == CardStyle.striped ? 0.3 : 1)
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                    
                    }
                    
                }
                .padding(.vertical)
            }
           
            .frame(maxWidth: .infinity, maxHeight: geometry.size.height)
           
            .selectify(isSelected: card.isSelected)
           
        }
        
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameVM())
.previewInterfaceOrientation(.portrait)
    }
}
