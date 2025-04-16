//
//  CenteredScroller+Preview.swift
//  CenteredScroller
//
//  Created by lokesh pandey on 15/04/25.
//

#if DEBUG
import SwiftUI


struct MockScrollerPreview: View {
    @State var selected: UUID
    let items: [MockItem]
    
    init() {
            self.items = (1...10).map { MockItem(id: UUID(), value: $0) }
            self._selected = State(initialValue: items[items.count / 2].id)
        }

    var body: some View {
        
        CenteredScroller(selectedItem: $selected, items: items) { item, selected in
            Text(item.displayText)
                .padding()
                .background(selected ? Color.blue : Color.gray.opacity(0.3))
                .cornerRadius(8)
            
            
        }
    }

    struct MockItem: ScrollableItem {
        let id: UUID
        let value: Int
        var displayText: String { "\(value)" }
    }
}

#Preview {
    MockScrollerPreview()
}
#endif
