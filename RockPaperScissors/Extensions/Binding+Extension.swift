//
//  Binding+Extension.swift
//  RockPaperScissors
//
//  Created by Mark Perryman on 11/27/20.
//

import SwiftUI

extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
 }
