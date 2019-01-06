//
//  TextFieldsTraversalAccessoryView.swift
//  TextFieldsTraversalController
//
//  Created by Daniel Inoa on 10/10/17.
//  Copyright © 2017 Daniel Inoa. All rights reserved.
//

import UIKit

/// A toolbar intended to be used as an inputAccessoryView when traversing through a collection of textfields.
/// This view contains 3 bar button items: a `previous`, a `next`, and a `done` bar button item.
open class TextFieldsTraversalAccessoryView: UIToolbar {
    
    // MARK: - Orientation
    
    public var orientation: Orientation = .horizontal {
        didSet {
            switch orientation {
            case .horizontal:
                previousItem.image = image(forDirection: .left)
                nextItem.image = image(forDirection: .right)
            case .vertical:
                previousItem.image = image(forDirection: .up)
                nextItem.image = image(forDirection: .down)
            }
        }
    }
    
    public enum Orientation {
        case vertical
        case horizontal
    }
    
    // MARK: - Items
    
    let previousItem = UIBarButtonItem()
    let nextItem = UIBarButtonItem()
    let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixed = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixed.width = 20
        setItems([previousItem, fixed, nextItem, flexible, doneItem], animated: false)
        orientation = .horizontal
    }
    
    // MARK: - Image
    
    private func image(forDirection direction: Direction) -> UIImage {
        let upArrowImage = imageForUpArrow()
        let image = UIImage(cgImage: upArrowImage.cgImage!, scale: upArrowImage.scale, orientation: direction.imageOrientation)
        return image
    }
    
    private func imageForUpArrow() -> UIImage {
        let lineWidth: CGFloat = 1.5
        let ratio: CGFloat = 5.0 / 9.0
        let dimension: CGFloat = 20
        let size = CGSize(width: dimension, height: dimension * ratio)
        let bounds = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.black.setStroke()
        path.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: Direction
    
    private enum Direction {
        case left
        case right
        case up
        case down
        var imageOrientation: UIImage.Orientation {
            switch self {
            case .up: return .up
            case .down: return .down
            case .left: return .left
            case .right: return .right
            }
        }
    }
}
