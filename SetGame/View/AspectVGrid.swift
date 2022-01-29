//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Samuel Alake on 1/18/22.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView>: View where ItemView : View{
    var items: [Item]
    var numOfItemsToShow: Int
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], numOfItemsToShow: Int, aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView){
        self.items = items
        self.numOfItemsToShow = numOfItemsToShow
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        VStack {
            GeometryReader{ geometry in
                let width: CGFloat = widthThatFits(itemCount: numOfItemsToShow, in: geometry.size, itemAspectRatio: aspectRatio)
                VStack {
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                        ForEach(items[0..<numOfItemsToShow]) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                                .padding(8)
                        }
                    }
                }
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem{
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat{
        var columnCount = 1
        var rowCount = itemCount
        
        repeat{
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            
            if CGFloat(rowCount) * itemHeight < size.height{
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
            
        }while (columnCount < itemCount)
        
        if columnCount > itemCount{
            columnCount = itemCount
        }
    
        return floor(size.width / CGFloat(columnCount))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
