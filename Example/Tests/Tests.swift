import UIKit
import XCTest
import TextFieldsTraversalController

final class TextFieldsTraversalControllerTests: XCTestCase {

    @MainActor
    func testNavigationItemsReflectCurrentTextField() {
        let firstTextField = UITextField()
        let secondTextField = UITextField()
        let controller = TextFieldsTraversalController(textFields: [firstTextField, secondTextField])

        beginEditing(firstTextField)
        waitForMainQueue()

        XCTAssertFalse(controller.accessoryView.previousItem.isEnabled)
        XCTAssertTrue(controller.accessoryView.nextItem.isEnabled)

        beginEditing(secondTextField)
        waitForMainQueue()

        XCTAssertTrue(controller.accessoryView.previousItem.isEnabled)
        XCTAssertFalse(controller.accessoryView.nextItem.isEnabled)
    }

    @MainActor
    func testDisabledFieldsAreSkipped() {
        let firstTextField = UITextField()
        let secondTextField = UITextField()
        let thirdTextField = UITextField()
        let controller = TextFieldsTraversalController(textFields: [firstTextField, secondTextField, thirdTextField])

        secondTextField.isEnabled = false
        beginEditing(firstTextField)
        waitForMainQueue()

        XCTAssertFalse(controller.accessoryView.previousItem.isEnabled)
        XCTAssertTrue(controller.accessoryView.nextItem.isEnabled)

        beginEditing(thirdTextField)
        waitForMainQueue()

        XCTAssertTrue(controller.accessoryView.previousItem.isEnabled)
        XCTAssertFalse(controller.accessoryView.nextItem.isEnabled)
    }

    @MainActor
    func testIgnoresUnmanagedTextFieldNotifications() {
        let managedTextField = UITextField()
        let unmanagedTextField = UITextField()
        let controller = TextFieldsTraversalController(textFields: [managedTextField])

        beginEditing(unmanagedTextField)
        waitForMainQueue()

        XCTAssertFalse(controller.accessoryView.previousItem.isEnabled)
        XCTAssertFalse(controller.accessoryView.nextItem.isEnabled)
    }

    private func beginEditing(_ textField: UITextField) {
        NotificationCenter.default.post(
            name: UITextField.textDidBeginEditingNotification,
            object: textField
        )
    }

    private func waitForMainQueue() {
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.01))
    }
}
