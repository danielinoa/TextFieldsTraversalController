//
//  TextFieldsTraversalAccessoryView.swift
//  TextFieldsTraversalController
//
//  Created by Daniel Inoa on 10/10/17.
//  Copyright © 2017 Daniel Inoa. All rights reserved.
//

import UIKit

/// An input accessory view used when traversing through a collection of text fields.
/// This view contains 3 bar button items: a `previous`, a `next`, and a `done` bar button item.
open class TextFieldsTraversalAccessoryView: UIView {
    
    // MARK: - Orientation
    
    public var orientation: Orientation = .horizontal {
        didSet {
            applyOrientation()
        }
    }
    
    public enum Orientation {
        case vertical
        case horizontal
    }
    
    // MARK: - Items
    
    public let previousItem: UIBarButtonItem = TextFieldsTraversalBarButtonItem()
    public let nextItem: UIBarButtonItem = TextFieldsTraversalBarButtonItem()
    public let doneItem: UIBarButtonItem = TextFieldsTraversalBarButtonItem()

    // MARK: - Views

    private let backgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        view.clipsToBounds = true
        return view
    }()

    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let doneButton = UIButton(type: .system)

    private enum Layout {
        static let accessoryHeight: CGFloat = 72
        static let barInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        static let barContentInset: CGFloat = 18
        static let buttonSize = CGSize(width: 44, height: 44)
        static let buttonSpacing: CGFloat = 12
    }
    
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
        backgroundColor = .clear
        addSubview(backgroundView)
        backgroundView.contentView.addSubview(previousButton)
        backgroundView.contentView.addSubview(nextButton)
        backgroundView.contentView.addSubview(doneButton)

        [previousButton, nextButton, doneButton].forEach(configure)
        previousButton.addTarget(self, action: #selector(tappedPrevious), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(tappedNext), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(tappedDone), for: .touchUpInside)

        bind(previousItem, to: previousButton)
        bind(nextItem, to: nextButton)
        bind(doneItem, to: doneButton)
        applyOrientation()
        doneItem.image = image(forSystemName: "checkmark", pointSize: 26, weight: .medium)
    }

    private func configure(_ button: UIButton) {
        button.tintColor = .label
    }

    private func bind(_ item: UIBarButtonItem, to button: UIButton) {
        guard let item = item as? TextFieldsTraversalBarButtonItem else {
            return
        }

        item.onImageChanged = { [weak button] image in
            button?.setImage(image, for: .normal)
        }
        item.onEnabledChanged = { [weak button] isEnabled in
            button?.isEnabled = isEnabled
        }
        button.setImage(item.image, for: .normal)
        button.isEnabled = item.isEnabled
    }

    private func applyOrientation() {
        switch orientation {
        case .horizontal:
            previousItem.image = image(forSystemName: "chevron.left", pointSize: 26, weight: .medium)
            nextItem.image = image(forSystemName: "chevron.right", pointSize: 26, weight: .medium)
        case .vertical:
            previousItem.image = image(forSystemName: "chevron.up", pointSize: 26, weight: .medium)
            nextItem.image = image(forSystemName: "chevron.down", pointSize: 26, weight: .medium)
        }
    }

    open override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: Layout.accessoryHeight)
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        CGSize(width: size.width, height: intrinsicContentSize.height)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        backgroundView.frame = bounds.inset(by: Layout.barInsets)
        backgroundView.layer.cornerRadius = backgroundView.bounds.height / 2

        let contentBounds = backgroundView.contentView.bounds.insetBy(dx: Layout.barContentInset, dy: 0)
        let buttonY = contentBounds.midY - Layout.buttonSize.height / 2
        previousButton.frame = CGRect(
            x: contentBounds.minX,
            y: buttonY,
            width: Layout.buttonSize.width,
            height: Layout.buttonSize.height
        )
        nextButton.frame = CGRect(
            x: previousButton.frame.maxX + Layout.buttonSpacing,
            y: buttonY,
            width: Layout.buttonSize.width,
            height: Layout.buttonSize.height
        )
        doneButton.frame = CGRect(
            x: contentBounds.maxX - Layout.buttonSize.width,
            y: buttonY,
            width: Layout.buttonSize.width,
            height: Layout.buttonSize.height
        )
    }
    
    // MARK: - Image
    
    private func image(forSystemName systemName: String, pointSize: CGFloat, weight: UIImage.SymbolWeight) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        return UIImage(systemName: systemName, withConfiguration: configuration)
    }

    // MARK: Actions

    @objc private func tappedPrevious() {
        sendAction(for: previousItem)
    }

    @objc private func tappedNext() {
        sendAction(for: nextItem)
    }

    @objc private func tappedDone() {
        sendAction(for: doneItem)
    }

    private func sendAction(for item: UIBarButtonItem) {
        guard item.isEnabled,
              let target = item.target,
              let action = item.action else {
            return
        }

        UIApplication.shared.sendAction(action, to: target, from: item, for: nil)
    }
}

private final class TextFieldsTraversalBarButtonItem: UIBarButtonItem {

    var onImageChanged: ((UIImage?) -> Void)?
    var onEnabledChanged: ((Bool) -> Void)?

    override var image: UIImage? {
        didSet {
            onImageChanged?(image)
        }
    }

    override var isEnabled: Bool {
        didSet {
            onEnabledChanged?(isEnabled)
        }
    }
}
