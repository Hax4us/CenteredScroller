//
//  DefaultCellView.swift
//  CenteredScroller
//
//  Created by lokesh pandey on 15/04/25.
//

import SwiftUI

public struct DefaultCellView<Item: ScrollableItem>: View {
    public var item: Item
    public var isSelected: Bool

    public init(item: Item, isSelected: Bool) {
        self.item = item
        self.isSelected = isSelected
    }

    public var body: some View {
        VStack {
            Text(item.displayText)
                .font(isSelected ? .title : .title3)
                .padding()
        }
    }
}

