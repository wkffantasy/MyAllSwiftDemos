//
//  SectorView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/20.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class SectorView: UIView {

    var title: String!
    var radius: CGFloat!
    var singleAngle: CGFloat!
    var titleLabel: UILabel!

    init(frame: CGRect, title: String, radius: CGFloat, singleAngle: CGFloat!) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        assert(title.length > 0, "")
        assert(radius > 0, "")
        assert(singleAngle > 0, "")
        self.title = title
        self.radius = radius
        self.singleAngle = singleAngle
    }

    override func draw(_: CGRect) {
        UIColor.white.setFill()
        let point = CGPoint(x: self.frame.size.width / 2, y: 0)
        let startAngle = CGFloat(M_PI / 2) - singleAngle / 2
        let endAngle = startAngle + singleAngle
        let path = UIBezierPath()
        path.move(to: point)
        path.addArc(withCenter: point, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.addLine(to: point)
        path.lineWidth = 1
        path.fill()
        path.close()
        print("self.layer.position", self.layer.position)
        print("self.frame", self.frame)
        print("self.layer.anchorPoint", self.layer.anchorPoint)
        setupLabel()
    }

    func setupLabel() {
        if titleLabel != nil {
            return
        }
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.colorWithHexString("333333")
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
