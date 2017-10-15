//
//  ViewController.swift
//  TextFieldCollection
//
//  Created by Daniel Inoa on 6/23/17.
//  Copyright © 2017 Daniel Inoa. All rights reserved.
//

import UIKit
import TextFieldsTraversalController

final class ViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    private var textFieldsTraversalController: TextFieldsTraversalController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldsTraversalController = TextFieldsTraversalController(textFields: textFields)
    }
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBAction func toggleEnabled(_ sender: UIBarButtonItem) {
        firstTextField.isEnabled = !firstTextField.isEnabled
        sender.title = !firstTextField.isEnabled ? "Enable First" : "Disable First"
    }
    
    @IBAction func toggleOrientation(_ sender: Any) {
        let accessoryView = textFieldsTraversalController.accessoryView
        switch accessoryView.orientation {
        case .horizontal: accessoryView.orientation = .vertical
        case .vertical: accessoryView.orientation = .horizontal
        }
    }
}

