TextFieldsTraversalController
===========

A controller to manage the traversal of a collection of textields. 
This controller comes with a custom inputAccessoryView that mimics the one used in Safari when traversing through forms.


[![CI Status](http://img.shields.io/travis/danielinoa/TextFieldsTraversalController.svg?style=flat)](https://travis-ci.org/danielinoa/TextFieldsTraversalController)
[![Version](https://img.shields.io/cocoapods/v/TextFieldsTraversalController.svg?style=flat)](http://cocoapods.org/pods/TextFieldsTraversalController)
[![License](https://img.shields.io/cocoapods/l/TextFieldsTraversalController.svg?style=flat)](http://cocoapods.org/pods/TextFieldsTraversalController)
[![Platform](https://img.shields.io/cocoapods/p/TextFieldsTraversalController.svg?style=flat)](http://cocoapods.org/pods/TextFieldsTraversalController)

<img src="https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/SS1.png" height="640"></a>
<img src="https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/SS2.png" height="640"></a>

## Usage

`import TextFieldsTraversalController`

```swift
let textFieldsTraversalController = TextFieldsTraversalController(textFields: textFields)
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Customization

```
textFieldsTraversalController.accessoryView.orientation = .horizontal
```

![image](https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/horizontal.png)

```
textFieldsTraversalController.accessoryView.orientation = .vertical
```

![image](https://github.com/danielinoa/TextFieldsTraversalController/blob/master/Screenshots/vertical.png)


## Requirements

* iOS 9.0+ and Xcode 9.0+
* Swift 4.0+

## Installation

TextFieldsTraversalController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod 'TextFieldsTraversalController'
```

## Author

* [Daniel Inoa](https://www.danielinoa.com)

## License

TextFieldsTraversalController is available under the MIT license. See the LICENSE file for more info.
