//
//  View+Modifier.swift
//  CenteredScroller
//
//  Created by lokesh pandey on 15/04/25.
//

import SwiftUI

extension View {
    func midX(completion: @escaping (Int) -> Void) -> some View {
        self
            .modifier(CenterFinder(onChange: completion))
    }
}


struct CenterFinder: ViewModifier {
    var onChange: (Int)->Void
    @State var currentIndex: Int = 0
    @State var previousIndex: Int = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    
                    var center = Int(proxy.frame(in: .global).midX)
                    
                    Color.clear
                        .preference(key: MidXKey.self, value: center)
                        .onPreferenceChange(MidXKey.self) { value in
                            onChange(value)
                        }
                }
            }
    }
}


struct MidXKey: PreferenceKey {
    static let defaultValue: Int = 0
    static func reduce(value: inout Int, nextValue: () -> Int) {
        value = nextValue()
    }
}
