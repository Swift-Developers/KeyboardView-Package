//
//  KeyButton.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

/**
 This demo-specific button view represents a keyboard button
 like the one used in the iOS system keyboard. The file also
 contains `KeyboardAction` extensions used by this class.
 */
class KeyButton: KeyboardButtonView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController) {
        super.setup(with: action, in: viewController)
        backgroundColor = .clearInteractable
        width = action.buttonWidth
        titleLabel?.font = action.systemFont
        setTitle(action.buttonText, for: .normal)
        setTitleColor(action.tintColor, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        backgroundColor = action.buttonColor
        layer.cornerRadius = 4

        DispatchQueue.main.async {
            self.setImage(action.buttonImage, for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if useDark {
            applyShadow(.standardButtonShadowDark)
        } else {
            applyShadow(.standardButtonShadowLight)
        }
    }
    
    var useDark: Bool = false
}


// MARK: - Private button-specific KeyboardAction Extensions

private extension KeyboardAction {
    
    var buttonColor: UIColor { useDarkButton ? Asset.Colors.systemButton.color : Asset.Colors.button.color }
    
    var tintColor: UIColor { useDarkButton ? Asset.Colors.systemButtonText.color : Asset.Colors.buttonText.color }
    
    var buttonImage: UIImage? {
        switch self {
        case .image(_, let imageName, _): return UIImage(named: imageName)
        case .nextKeyboard: return Asset.Images.Buttons.switchKeyboard.image
        default: return nil
        }
    }
    
    var buttonText: String? {
        switch self {
        case .backspace:                            return "⌫"
        case .character(let text),
             .emoji(let text):                      return text
        case .keyboardType(let type):               return buttonText(for: type)
        case .newLine:                              return "return"
        case .done:                                 return "done"
        case .shift:                                return "⇧"
        case .space:                                return "space"
        default:                                    return nil
        }
    }
    
    func buttonText(for keyboardType: KeyboardType) -> String {
        switch keyboardType {
        case .alphabetic:                           return "ABC"
        case .numeric:                              return "123"
        case .symbolic:                             return "#+="
        case .custom(let value):                    return value
        default:                                    return "???"
        }
    }
    
    var buttonWidth: CGFloat {
        switch self {
        case .none: return 10.auto()
        case .shift, .backspace: return 42.auto()
        case .keyboardType(.numeric):    return 88.auto()
        case .keyboardType(.symbolic):    return 42.auto()
        case .keyboardType(.alphabetic):    return 88.auto()
        case .newLine:    return 88.auto()
        case .done:       return 88.auto()
        case .space: return 182.auto()
        case .character(let value) where [".", ",", "?", "!", "´"].contains(value):
            return 45.auto()
        case .keyboardType(.custom(let value)) where value == "123":
            return 42.auto()
            
        default: return 32.auto()
        }
    }

    var useDarkButton: Bool {
        switch self {
        case .character, .image, .space:        return false
        case .shift(let currentState):          return currentState != .lowercased
        default: return true
        }
    }
}

extension UIInputViewController {
    
    var isDarkAppearance: Bool {
        if #available(iOS 12.0, *) {
            return traitCollection.userInterfaceStyle == .dark
        } else {
            let appearance = textDocumentProxy.keyboardAppearance ?? .default
            return appearance == .dark
        }
    }
}
