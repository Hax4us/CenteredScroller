# CenteredScroller

A lightweight, customizable SwiftUI component that displays horizontally scrollable items — automatically centering the closest item when scrolling stops.

Perfect for use cases like selecting dates, options, or any list of tappable items in a carousel style.

---

## ✨ Features

- 📦 Swift Package – Easy to integrate
- 🌀 Snaps to center when scrolling stops
- 🎨 Custom rendering via SwiftUI views
- ✅ Supports any `Identifiable` + `Equatable` type
- 🧪 Preview + test-friendly

---

## 📸 Example

```swift
import CenteredScroller
import SwiftUI

struct ExampleView: View {
    @State private var selectedId: UUID

    struct Item: ScrollableItem {
        let id: UUID
        let label: String
    }

    let items: [Item] = (1...10).map {
        Item(id: UUID(), label: "Item \($0)")
    }

    var body: some View {
        CenteredScroller(selectedItem: $selectedId, items: items) { item, isSelected in
            Text(item.label)
                .padding()
                .background(isSelected ? Color.blue : Color.gray.opacity(0.3))
                .cornerRadius(8)
        }
    }
}

