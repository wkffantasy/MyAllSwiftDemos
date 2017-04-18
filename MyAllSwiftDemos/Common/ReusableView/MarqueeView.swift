//
//  MarqueeView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class MarqueeView: UIView {

    private var firstLabel: UILabel!
    private var secondLabel: UILabel?
    private var containerView: UIView!

    private var titleFont: UIFont! = UIFont.systemFont(ofSize: 17)
    private var titleColor: UIColor! = UIColor.colorWithHexString("333333")
    private var title: String!

    private let animationKey = "containerView animation"
    private let labelMargin: CGFloat = 20.0

    // init with text
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        assert(text.length > 0, "")
        setupViews(frame: frame, text: text, font: titleFont, color: titleColor)
    }

    // init with text and font
    init(frame: CGRect, text: String, font: UIFont) {
        super.init(frame: frame)
        assert(text.length > 0, "")
        setupViews(frame: frame, text: text, font: font, color: titleColor)
    }

    // init with text ,font and color
    init(frame: CGRect, text: String, font: UIFont, color: UIColor) {
        super.init(frame: frame)
        assert(text.length > 0, "")
        setupViews(frame: frame, text: text, font: font, color: color)
    }

    // init with text and color
    init(frame: CGRect, text: String, color: UIColor) {
        super.init(frame: frame)
        assert(text.length > 0, "")
        setupViews(frame: frame, text: text, font: titleFont, color: color)
    }

    public func updateContent(text: String, font: UIFont, color: UIColor) {
        assert(text.length > 0, "")

        titleFont = font
        title = text
        titleColor = color

        firstLabel.text = text
        firstLabel.font = titleFont
        firstLabel.textColor = titleColor

        secondLabel?.text = text
        secondLabel?.font = titleFont
        secondLabel?.textColor = titleColor

        self.layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews(frame: CGRect,
                            text: String,
                            font: UIFont,
                            color: UIColor) {

        self.clipsToBounds = true
        self.isUserInteractionEnabled = false
        self.frame = frame
        self.title = text
        self.titleFont = font
        self.titleColor = color

        containerView = UIView.init(frame: self.bounds)
        containerView.backgroundColor = UIColor.clear
        self.addSubview(containerView)

        firstLabel = setupLabel()
        containerView.addSubview(firstLabel)

        secondLabel = setupLabel()
        containerView.addSubview(secondLabel!)
    }

    private func setupLabel() -> UILabel {
        let label = UILabel.init()
        label.text = title
        label.textColor = titleColor
        label.font = titleFont
        label.textAlignment = .center
        return label
    }

    private func beganAnimate() {
        // move 20pt/s
        let speed: CGFloat = 20.0
        let animate = CABasicAnimation()
        animate.fromValue = 0
        animate.toValue = -self.firstLabel.frame.size.width - labelMargin
        animate.keyPath = "transform.translation.x"
        animate.duration = CFTimeInterval((firstLabel.frame.size.width + labelMargin) / speed)
        animate.isRemovedOnCompletion = true
        animate.repeatCount = MAXFLOAT
        containerView.layer.add(animate, forKey: animationKey)
    }

    private func beReadyToAnimatie(frame: CGRect) {
        let attributes: Dictionary<String, AnyObject> = [NSFontAttributeName: self.titleFont]
        let attributedText = NSMutableAttributedString(string: self.title, attributes: attributes)
        let labelRect = attributedText.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: self.frame.size.height), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        if labelRect.size.width <= frame.size.width {
            firstLabel.frame = frame
            secondLabel?.isHidden = true
            containerView.layer.removeAnimation(forKey: animationKey)
        } else {
            secondLabel?.isHidden = false
            firstLabel.frame = CGRect(x: 0, y: 0, width: labelRect.size.width, height: self.frame.size.height)
            secondLabel?.frame = CGRect(x: labelRect.size.width + labelMargin, y: 0, width: labelRect.size.width, height: self.frame.size.height)
            beganAnimate()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.beReadyToAnimatie(frame: self.bounds)
    }

    deinit {
        containerView.layer.removeAnimation(forKey: animationKey)
    }
}
