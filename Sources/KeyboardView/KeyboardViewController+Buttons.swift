//
//  KeyboardViewController+Buttons.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func button(for action: KeyboardAction) -> UIView {
        switch action {
        case .custom(let value):
            guard let width = Double(value) else {
                return KeyboardSpacerView(width: 0)
            }

            return KeyboardSpacerView(width: CGFloat(width))
            
        default:
            let view = KeyButton()
            view.setup(with: action, in: self)
            return view
        }
    }
    
    func buttonRow(for actions: KeyboardActionRow) -> KeyboardStackViewComponent {
        KeyboardButtonRowView(actions: actions) {
            button(for: $0)
        }
    }
    
    func buttonRows(for actionRows: KeyboardActionRows) -> [KeyboardStackViewComponent] {
        return actionRows.map {
            buttonRow(for: $0)
        }
    }
}

class KeyboardButtonRowView: UIView, KeyboardStackViewComponent {
    
    convenience init(
        height: CGFloat = Constant.vertical.keyHeight,
        actions: KeyboardActionRow,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .equalSpacing,
        spacing: CGFloat = 5.auto(),
        buttonCreator: KeyboardButtonCreator) {
        self.init(frame: .zero)
        self.height = height
        buttonStackView.alignment = alignment
        buttonStackView.distribution = distribution
        buttonStackView.spacing = spacing
        buttonStackView.addArrangedSubviews(actions.map { buttonCreator($0) })
    }
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    public var heightConstraint: NSLayoutConstraint?
    
    public lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        addSubview(stackView, fill: true)
        return stackView
    }()
}
