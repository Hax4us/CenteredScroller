//
//  FrameReader.swift
//  CenteredScroller
//
//  Created by lokesh pandey on 15/04/25.
//

import SwiftUI

public extension View {
    func frame(in coordinateSpace: CoordinateSpace = .global, completion: @escaping (CGRect) -> Void) -> some View {
        self.background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: FramePreferenceKey.self, value: proxy.frame(in: coordinateSpace))
            }
        )
        .onPreferenceChange(FramePreferenceKey.self, perform: completion)
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static let defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
