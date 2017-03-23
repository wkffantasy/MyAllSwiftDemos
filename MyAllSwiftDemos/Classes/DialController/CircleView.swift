//
//  CircleView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/22.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class CircleView: UIView {

    private var totalCount: Int!
    init(frame: CGRect, totalCount: Int) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width / 2
        assert(totalCount > 1, "")
        backgroundColor = UIColor.white
        self.totalCount = totalCount
    }

    override func draw(_: CGRect) {
        let radius = self.frame.size.width / 2
        let marginAngle = CGFloat(M_PI) * 2 / CGFloat(totalCount)
        assert(totalCount > 1, "")
        for index in 0 ..< totalCount {
            let thisAngle = CGFloat(index) * marginAngle + marginAngle / 2
            let SinX = radius * sin(thisAngle)
            let CosY = radius * cos(thisAngle)
            let beganX = radius + SinX
            let endX = radius + SinX / 1.5
            let beganY = radius + CosY
            let endY = radius + CosY / 1.5
            let beganPoint = CGPoint(x: beganX, y: beganY)
            let endPoint = CGPoint(x: endX, y: endY)
            let path = UIBezierPath()
            UIColor.colorWithRGB(red: 52, green: 146, blue: 244).setStroke()
            path.move(to: beganPoint)
            path.addLine(to: endPoint)
            path.lineWidth = 2.0
            path.stroke()
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
