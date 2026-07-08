TextFieldsTraversalController
===========

A controller to manage the traversal of a collection of text fields.
This controller comes with a custom `inputAccessoryView` that mimics the one used by Safari when traversing through an HTML form.


[![CI](https://github.com/danielinoa/TextFieldsTraversalController/actions/workflows/ci.yml/badge.svg)](https://github.com/danielinoa/TextFieldsTraversalController/actions/workflows/ci.yml)
[![Swift Package Manager](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

<img src="https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/SS1.png" height="640"></a>
<img src="https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/SS2.png" height="640"></a>

## Usage

`import TextFieldsTraversalController`

```swift
let textFieldsTraversalController = TextFieldsTraversalController(textFields: textFields)
```

To run the example project, clone the repo and open `Example/TextFieldsTraversalController.xcodeproj`.

## Customization

```
textFieldsTraversalController.accessoryView.orientation = .horizontal
```

![image](https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/horizontal.png)

```
textFieldsTraversalController.accessoryView.orientation = .vertical
```

![image](https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/vertical.png)

The arrow buttons are disabled automatically at the first and last enabled text fields.

<img src="https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/previous-disabled-full.png" height="640"></a>
<img src="https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/next-disabled-full.png" height="640"></a>

![previous disabled](https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/previous-disabled.png)

![next disabled](https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/next-disabled.png)


## Requirements

* iOS 18.0+
* Swift 6.3+
* Xcode 26.6+ or another toolchain that supports Swift 6.3

## Installation

Add this repository as a package dependency in Xcode or in `Package.swift`:

```swift
.package(url: "https://github.com/danielinoa/TextFieldsTraversalController.git", from: "2.0.0")
```

## Author

* [Daniel Inoa](https://www.danielinoa.com)

## License

TextFieldsTraversalController is available under the MIT license. See the LICENSE file for more info.
