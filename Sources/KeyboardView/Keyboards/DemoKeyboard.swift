//
//  DemoKeyboard.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-05-14.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit
/**
 This protocol is used by the demo application keyboards and
 provides shared functionality.
 
 The demo keyboards are for demo purposes, so they lack some
 functionality, like adapting to languages, device types etc.
 */
protocol DemoKeyboard {}

extension DemoKeyboard {
    
    static func bottomActions(leftmost: KeyboardAction, rightmost: KeyboardAction = .done, for vc: KeyboardViewController) -> KeyboardActionRow {
        return [leftmost, .space, rightmost]
    }
}
