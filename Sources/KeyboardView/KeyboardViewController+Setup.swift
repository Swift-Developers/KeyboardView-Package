//
//  KeyboardViewController+Setup.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func setupKeyboard(for size: CGSize) {
        func setupAlphabeticKeyboard(for state: KeyboardShiftState) {
            let keyboard = AlphabeticKeyboard(uppercased: state.isUppercased, in: self)
            let rows = buttonRows(for: keyboard.actions)
            keyboards.stack(for: .alphabetic(state))?.addArrangedSubviews(rows)
        }
        func setupNumericKeyboard() {
            let keyboard = NumericKeyboard(in: self)
            let rows = buttonRows(for: keyboard.actions)
            keyboards.stack(for: .numeric)?.addArrangedSubviews(rows)
        }
        
        func setupSymbolicKeyboard() {
            let keyboard = SymbolicKeyboard(in: self)
            let rows = buttonRows(for: keyboard.actions)
            keyboards.stack(for: .symbolic)?.addArrangedSubviews(rows)
        }

        func setupKeyboard(for type: KeyboardType) {
            switch type {
            case .alphabetic(let state):
                setupAlphabeticKeyboard(for: state)
                
            case .numeric:
                setupNumericKeyboard()
                
            case .symbolic:
                setupSymbolicKeyboard()
                
            case .custom(let value) where value == "123":
                setupNumericKeyboard()
                
            default: return
            }
        }
        
        keyboardTypes.forEach { setupKeyboard(for: $0) }
        keyboardStackView.addArrangedSubviews(keyboards.views)
        changeKeyboardType(to: context.keyboardType)
    }
    
    func changeKeyboardType(_ type: KeyboardType) {
        switch type {
        case .custom(let value) where value == "123":
            keyboards.forEach { $0.stackView.isHidden = $0.keyboardType != .numeric }
            
        default:
            keyboards.forEach { $0.stackView.isHidden = $0.keyboardType != type }
        }
    }
}
