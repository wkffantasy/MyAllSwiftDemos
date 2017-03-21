//
//  DialView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/20.
//  Copyright © 2017年 fantasy. All rights reserved.
//

/*

 */
import UIKit

class DialView: UIView {

    typealias ClickAreaBlock = (Int) -> Void

    private var titleArray: Array<String>!
    private var clickButtonBlock: ClickAreaBlock?

    private var singleAngle: CGFloat!
    private var singleHalfAngle: CGFloat!
    private var radius: CGFloat!
    private var thisCenter: CGPoint!

    init(frame: CGRect, titleArray: Array<String>) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
        assert(titleArray.count > 1, "")
        singleAngle = CGFloat(2 * M_PI) / CGFloat(titleArray.count)
        singleHalfAngle = singleAngle / 2
        radius = frame.size.height
        self.titleArray = titleArray
        thisCenter = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        radius = frame.size.width / 2
        setupSectorViews()
    }
    func setupSectorViews() {
        let thisSectorWidth = caculateWidth()
        let sector = SectorView.init(frame: CGRect(x:self.frame.size.width/2-thisSectorWidth/2,y:self.frame.size.width/2,width:thisSectorWidth,height:radius), title: titleArray[0], radius: radius, singleAngle: singleAngle)
        addSubview(sector)
    }
    func caculateWidth() -> CGFloat {
        let thisWidth = radius * sin(singleHalfAngle)*2
        return thisWidth
    }
//    override func draw(_: CGRect) {
//        UIColor.red.set()
//        UIColor.blue.setFill()
//        UIColor.yellow.setStroke()
//        var index: CGFloat = 0
//        for title in titleArray {
//            print("index == ", index)
//            print("title == ", title)
//            let startAngle = CGFloat(M_PI / 2) + index * singleAngle - singleHalfAngle
//            let endAngle = startAngle + singleAngle
//
//            let path = UIBezierPath()
//            path.move(to: thisCenter)
//            path.addArc(withCenter: thisCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//            path.addLine(to: thisCenter)
//            path.lineWidth = 1
//            path.stroke()
//            path.fill()
//
//            path.close()
//            index += 1
//        }
//    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
