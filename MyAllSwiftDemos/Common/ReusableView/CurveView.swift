//
//  CurveView.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class CurveView: UIView {

    var thisHeight: CGFloat!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        thisHeight = curveMaxHeight
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateMaxHeight(thisHeight: CGFloat) {

        self.thisHeight = thisHeight
        self.layoutIfNeeded()
    }

    override func draw(_: CGRect) {

        let path = UIBezierPath.init()
        path.move(to: .zero)
        path.addQuadCurve(to: CGPoint(x: self.frame.size.width, y: 0), controlPoint: CGPoint(x: self.frame.size.width / 2, y: thisHeight))
        UIColor.yellow.setFill()
        path.fill()
    }
}
