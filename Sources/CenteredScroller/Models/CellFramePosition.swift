//
//  CellFramePosition.swift
//  CenteredScroller
//
//  Created by lokesh pandey on 15/04/25.
//

import Foundation

public struct CellFramePosition<Item: ScrollableItem>: Equatable {
    public var cell: Item
    public var minx: Int
    public var maxx: Int

    public init(cell: Item, minx: Int, maxx: Int) {
        self.cell = cell
        self.minx = minx
        self.maxx = maxx
    }
}
