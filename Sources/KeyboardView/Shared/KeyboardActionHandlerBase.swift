//
//  DemoAutocompleteSuggestionProvider.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/**
 This action handler inherits `StandardKeyboardActionHandler`
 and adds demo-specific base functionality to it.
 
 The class is shared between all keyboards. Each demo action
 handler inherit this class and adds functionality on top of
 the base functionality.
 */
class KeyboardActionHandlerBase: StandardKeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    init(inputViewController: KeyboardInputViewController) {
        super.init(
            inputViewController: inputViewController,
            hapticConfiguration: .standard
        )
    }
    
    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.handle(gesture, on: action, sender: sender)
    }
    
    /**
     `NOTE` Changing to alphabetic lower case should be done
     in `StandardKeyboardActionHandler`, not here.
     */
    func handleSpace(for sender: Any?) -> GestureAction {
        let baseAction = super.tapAction(for: .space, sender: sender)
        return { [weak self] in
            baseAction?()
            let type = self?.inputViewController?.context.keyboardType
            if type?.isAlphabetic == true { return }
            self?.inputViewController?.changeKeyboardType(to: .alphabetic(.lowercased))
        }
    }
    
    override func longPressAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        return super.longPressAction(for: action, sender: sender)
    }
    
    override func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .space: return handleSpace(for: sender)
        default: return super.tapAction(for: action, sender: sender)
        }
    }
}
