// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "TextFieldsTraversalController",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "TextFieldsTraversalController",
            targets: ["TextFieldsTraversalController"]
        )
    ],
    targets: [
        .target(
            name: "TextFieldsTraversalController",
            path: "Classes"
        )
    ],
    swiftLanguageModes: [.v6]
)
