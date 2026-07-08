//
//  TextFieldsTraversalController.swift
//  TextFieldsTraversalController
//
//  Created by Daniel Inoa on 10/10/17.
//  Copyright © 2017 Daniel Inoa. All rights reserved.
//

@preconcurrency import UIKit

/// This controller manages the traversal of a collection of text fields.
/// - note: Managing these text fields entails: assigning them with an input accessory view
///         and updating their state as first responders.
@MainActor public final class TextFieldsTraversalController {
    
    // MARK: - Observation
    
    private var observations: [NSKeyValueObservation] = []
    private var notificationObserver: NSObjectProtocol?
    
    // MARK: - Lifecycle
    
    public init(textFields: [UITextField]) {
        self.textFields = textFields
        textFields.forEach {
            $0.inputAccessoryView = accessoryView
            let observation = $0.observe(\.isEnabled) { [weak self] _, _ in
                DispatchQueue.main.async {
                    self?.configureAccessoryView()
                }
            }
            observations.append(observation)
        }
        
        notificationObserver = NotificationCenter.default.addObserver(
            forName: UITextField.textDidBeginEditingNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            guard let textField = notification.object as? UITextField else {
                return
            }

            let textFieldID = ObjectIdentifier(textField)
            DispatchQueue.main.async {
                self?.textFieldDidBeginEditing(matching: textFieldID)
            }
        }

        accessoryView.previousItem.addTarget(self, action: #selector(tappedPrevious))
        accessoryView.nextItem.addTarget(self, action: #selector(tappedNext))
        accessoryView.doneItem.addTarget(self, action: #selector(tappedDone))
        configureAccessoryView()
    }
    
    isolated deinit {
        if let notificationObserver {
            NotificationCenter.default.removeObserver(notificationObserver)
        }
        observations.removeAll()
    }
    
    // MARK: - Text Fields
    
    public let textFields: [UITextField]
    
    private var enabledTextFields: [UITextField] {
        return textFields.filter { $0.isEnabled }
    }
    
    private weak var currentTextField: UITextField? {
        didSet {
            currentTextField?.becomeFirstResponder()
            currentTextField?.returnKeyType = currentTextField !== enabledTextFields.last ? .next : .default
            configureAccessoryView()
        }
    }
    
    private var previousTextField: UITextField? {
        let textFields = enabledTextFields
        guard let currentTextField,
              let indexOfCurrentTextField = textFields.firstIndex(where: { $0 === currentTextField }),
              indexOfCurrentTextField > textFields.startIndex else {
            return nil
        }

        return textFields[textFields.index(before: indexOfCurrentTextField)]
    }
    
    private var nextTextField: UITextField? {
        let textFields = enabledTextFields
        guard let currentTextField,
              let indexOfCurrentTextField = textFields.firstIndex(where: { $0 === currentTextField }) else {
            return nil
        }

        let nextIndex = textFields.index(after: indexOfCurrentTextField)
        return textFields.indices.contains(nextIndex) ? textFields[nextIndex] : nil
    }
    
    // MARK: Notifications
    
    private func textFieldDidBeginEditing(matching textFieldID: ObjectIdentifier) {
        guard let textField = textFields.first(where: { ObjectIdentifier($0) == textFieldID }) else {
            return
        }

        currentTextField = textField
    }
    
    // MARK: - Accessory View

    /// The view used as the textFields' inputAccessoryView.
    public let accessoryView: TextFieldsTraversalAccessoryView = {
        let view = TextFieldsTraversalAccessoryView()
        view.sizeToFit()
        return view
    }()
    
    private func configureAccessoryView() {
        guard let currentTextField,
              enabledTextFields.contains(where: { $0 === currentTextField }) else {
            accessoryView.previousItem.isEnabled = false
            accessoryView.nextItem.isEnabled = false
            return
        }

        accessoryView.previousItem.isEnabled = enabledTextFields.first !== currentTextField
        accessoryView.nextItem.isEnabled = enabledTextFields.last !== currentTextField
    }
    
    // MARK: Actions
    
    @objc private func tappedPrevious() {
        currentTextField = previousTextField ?? currentTextField
    }
    
    @objc private func tappedNext() {
        currentTextField = nextTextField ?? currentTextField
    }
    
    @objc private func tappedDone() {
        currentTextField?.resignFirstResponder()
        currentTextField = nil
    }
}

private extension UIBarButtonItem {
    
    func addTarget(_ target: AnyObject?, action: Selector?) {
        self.target = target
        self.action = action
    }
}
