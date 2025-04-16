//
//  CenteredScrollerModel.swift
//  CenteredScroller
//
//  Created by lokesh pandey on 15/04/25.
//

import Foundation

@MainActor
public class CenteredScrollerModel<Item: ScrollableItem>: ObservableObject {
    public init() {}

    public var visibleCells = [Item]()
    public var cellFramePositions = [CellFramePosition<Item>]()
    @Published public var closestCell: Item?
    private var center: Int = 0

    public func setCenter(x: Int) {
        center = x
    }

    public func trackVisibleCells(cell: Item, isVisible: Bool) {
        if isVisible {
            visibleCells.append(cell)
        } else {
            visibleCells.removeAll { $0.id == cell.id }
        }
    }

    public func trackCellFramePositions(frame: CellFramePosition<Item>) async {
        if let index = cellFramePositions.firstIndex(where: { $0.cell.id == frame.cell.id }) {
            cellFramePositions[index] = frame
        } else {
            cellFramePositions.append(frame)
        }

        if let cell = closestCellFromCenter() {
            closestCell = cell
        }
    }

    public func removeCellFramePosition(for cell: Item) {
        cellFramePositions.removeAll { $0.cell.id == cell.id }
    }

    public func closestCellFromCenter() -> Item? {
        let filtered = cellFramePositions.filter { visibleCells.contains($0.cell) }
        self.cellFramePositions = filtered
        let cellFramePos = filtered.min {
            abs($0.minx - center) < abs($1.maxx - center)
        } ?? cellFramePositions.first
        return cellFramePos?.cell
    }
}
