//
//  ScrollableItem.swift
//  CenteredScroller
//
//  Created by lokesh pandey on 15/04/25.
//

import Foundation

public protocol ScrollableItem: Identifiable, Equatable {
    var displayText: String { get }
}
