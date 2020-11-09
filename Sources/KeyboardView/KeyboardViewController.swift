//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

public class KeyboardViewController: KeyboardInputViewController {
    

    var keyboardTypes: [KeyboardType] = [.alphabetic(.lowercased), .alphabetic(.uppercased), .alphabetic(.capsLocked), .numeric, .symbolic]
    lazy var keyboards: [KeyboardWrapper] = keyboardTypes.map { KeyboardWrapper($0) }
    
    
    // MARK: - View Controller Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        context.actionHandler = KeyboardActionHandlerBase(inputViewController: self)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
//        setupKeyboard(for: view.bounds.size)
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(for: size)
    }
    
    
    // MARK: - Keyboard Functionality
    public override func setupKeyboard() {
        setupKeyboard(for: view.bounds.size)
    }
    
    public override func changeKeyboardType(to type: KeyboardType, after delay: DispatchTimeInterval = .milliseconds(0)) {
        context.changeKeyboardType(to: type, after: delay) {
            self.changeKeyboardType(type)
        }
    }
}

class KeyboardWrapper {
    
    let keyboardType: KeyboardType
    let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = Constant.vertical.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(_ keyboardType: KeyboardType) {
        self.keyboardType = keyboardType
    }
}

extension Array where Element == KeyboardWrapper {
    
    func stack(for keyboardType: KeyboardType) -> UIStackView? {
        first { $0.keyboardType == keyboardType }?.stackView
    }
    
    var views: [UIView] { map { $0.stackView } }
}
