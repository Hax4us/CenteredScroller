//
//  CenteredScroller.swift
//  CenteredScroller
//
//  Created by lokesh pandey on 15/04/25.
//

import SwiftUI

import IsScrolling

public struct CenteredScroller<Item: ScrollableItem, Cell: View>: View {
    @Binding public var selectedItem: Item.ID
    public let items: [Item]
    public let cellView: (Item, Bool) -> Cell

    @StateObject private var viewModel = CenteredScrollerModel<Item>()
    @State private var midX: CGFloat = 0.0
    @State private var isScrolling = false

    public init(
        selectedItem: Binding<Item.ID>,
        items: [Item],
        @ViewBuilder cellView: @escaping (Item, Bool) -> Cell
    ) {
        self._selectedItem = selectedItem
        self.items = items
        self.cellView = cellView
    }

    public var body: some View {
        VStack {
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: 25, height: 15)
                .offset(y: 10)

            HStack {
                Spacer()
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Spacer().frame(width: midX)
                            ForEach(items) { item in
                                cellView(item, selectedItem == item.id)
                                    .id(item.id)
                                    .onAppear {
                                        viewModel.trackVisibleCells(cell: item, isVisible: true)
                                    }
                                    .onDisappear {
                                        viewModel.trackVisibleCells(cell: item, isVisible: false)
                                        viewModel.removeCellFramePosition(for: item)
                                    }
                                    .frame(in: .global) { frame in
                                        print(frame)
                                        let cellFrame = CellFramePosition(
                                            cell: item,
                                            minx: Int(frame.minX),
                                            maxx: Int(frame.maxX)
                                        )
                                        Task {
                                            await viewModel.trackCellFramePositions(frame: cellFrame)
                                        }
                                    }
                            }
                            Spacer().frame(width: midX)
                        }
                    }
                    .scrollStatusMonitor($isScrolling, monitorMode: .exclusion)
                    .onAppear {
                        print("Scrolling to \(selectedItem)")
                        proxy.scrollTo(selectedItem, anchor: .center)
                    }
                    .onChange(of: isScrolling) { scrolling in
                        if !scrolling {
                            proxy.scrollTo(viewModel.closestCell?.id, anchor: .center)
                            if let cell = viewModel.closestCell {
                                selectedItem = cell.id
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .midX { value in
            self.midX = CGFloat(value)
            viewModel.setCenter(x: Int(value))
        }
    }
}
