//
//  TextFieldsTraversalController.swift
//  TextFieldsTraversalController
//
//  Created by Daniel Inoa on 10/10/17.
//  Copyright © 2017 Daniel Inoa. All rights reserved.
//

import UIKit

/// This controller manages the traversal of a collection of textields.
/// - note: Managing these text fields entails: assigning them with an input accessory view
///         and updating their state as first responders.
public class TextFieldsTraversalController {
    
    // MARK: - Observation
    
    private var observations: [NSKeyValueObservation] = []
    
    // MARK: - Lifecycle
    
    public init(textFields: [UITextField]) {
        self.textFields = textFields
        textFields.forEach {
            $0.inputAccessoryView = accessoryView
            let observation = $0.observe(\UITextField.isEnabled) { [unowned self] _, _ in
                self.configureAccessoryView()
            }
            observations.append(observation)
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidBeginEditing(_:)),
                                               name: .UITextFieldTextDidBeginEditing,
                                               object: nil)
        accessoryView.previousItem.addTarget(self, action: #selector(tappedPrevious))
        accessoryView.nextItem.addTarget(self, action: #selector(tappedNext))
        accessoryView.doneItem.addTarget(self, action: #selector(tappedDone))
        configureAccessoryView()
    }
    
    deinit {
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
            currentTextField?.returnKeyType = currentTextField != enabledTextFields.last ? .next : .default
            configureAccessoryView()
        }
    }
    
    private var previousTextField: UITextField? {
        guard let currentTextField = currentTextField,
            let indexOfCurrentTextField = enabledTextFields.index(of: currentTextField) else { return nil }
        let previousTextField = enabledTextFields.element(before: indexOfCurrentTextField)
        return previousTextField
    }
    
    private var nextTextField: UITextField? {
        guard let currentTextField = currentTextField,
            let indexOfCurrentTextField = enabledTextFields.index(of: currentTextField) else { return nil }
        let nextTextField = enabledTextFields.element(after: indexOfCurrentTextField)
        return nextTextField
    }
    
    // MARK: Notifications
    
    @objc private func textFieldDidBeginEditing(_ notification: Notification) {
        currentTextField = notification.object as? UITextField
    }
    
    // MARK: - Accessory View

    /// The view used as the textFields' inputAccessoryView.
    public let accessoryView: TextFieldsTraversalAccessoryView = {
        let view = TextFieldsTraversalAccessoryView()
        view.sizeToFit()
        return view
    }()
    
    private func configureAccessoryView() {
        accessoryView.previousItem.isEnabled = enabledTextFields.first != currentTextField
        accessoryView.nextItem.isEnabled = enabledTextFields.last != currentTextField
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

private extension Array {
    
    /// Returns the element after the specified index.
    func element(after index: Index) -> Element? {
        let nextIndex = index + 1
        return nextIndex < count ? self[nextIndex] : nil
    }
    
    /// Returns the element before the specified index.
    func element(before index: Index) -> Element? {
        let nextIndex = index - 1
        return nextIndex >= 0 ? self[nextIndex] : nil
    }
}

private extension UIBarButtonItem {
    
    func addTarget(_ target: AnyObject?, action: Selector?) {
        self.target = target
        self.action = action
    }
}
