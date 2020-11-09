//
//  AlphabeticKeyboard.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo keyboard mimicks an English alphabetic keyboard.
 */
struct AlphabeticKeyboard: DemoKeyboard {
    
    let actions: KeyboardActionRows
    
    init(uppercased: Bool, in viewController: KeyboardViewController) {
        actions = AlphabeticKeyboard.actions(uppercased: uppercased, in: viewController)
    }
}

private extension AlphabeticKeyboard {
    
    static func actions(
        uppercased: Bool,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        KeyboardActionRows(characters: characters(uppercased: uppercased))
            .addingSideActions(uppercased: uppercased)
            .appending(bottomActions(leftmost: .keyboardType(.numeric), for: viewController))
    }
    
    static let characters: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
    
    static func characters(uppercased: Bool) -> [[String]] {
        uppercased ? characters.uppercased() : characters
    }
}

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions(uppercased: Bool) -> [Iterator.Element] {
        var result = map { $0 }
        result[1].insert(.custom(name: 17.auto().string), at: 0)
        result[1].append(.custom(name: 17.auto().string))
        result[2].insert(uppercased ? .shift(currentState: .uppercased) : .shift(currentState: .lowercased), at: 0)
        result[2].insert(.custom(name: 6.auto().string), at: 1)
        result[2].append(.custom(name: 6.auto().string))
        result[2].append(.backspace)
        return result
    }
}
