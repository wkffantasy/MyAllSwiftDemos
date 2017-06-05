//
//  CircleAndCloudAnimateView.swift
//  toeflios
//
//  Created by fantasy on 17/5/26.
//  Copyright © 2017年 Facebook. All rights reserved.
//

import UIKit

class CircleAndCloudAnimateView: UIView {

    private let circleWH: CGFloat = 15

    override init(frame: CGRect) {
        super.init(frame: frame)

        // 云彩的动画
        addCloudAnimate()

        // 圆圈的动画
        addCircleAnimate()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 三个圆圈的动画
    func addCircleAnimate() {

        let circleOne = createImageViewAndAddIt()
        circleOne.image = UIImage.init(named: "LearnIntent_CircleYellow")
        circleOne.frame = CGRect(x: 40,
                                 y: self.center.y + 30,
                                 width: circleWH,
                                 height: circleWH)

        let circleTwo = createImageViewAndAddIt()
        circleTwo.image = UIImage.init(named: "LearnIntent_CircleRed")
        circleTwo.frame = CGRect(x: ScreenWidth - 70 - circleWH,
                                 y: 90,
                                 width: circleWH,
                                 height: circleWH)

        let circleThree = createImageViewAndAddIt()
        circleThree.image = UIImage.init(named: "LearnIntent_CircleBlue")
        circleThree.frame = CGRect(x: ScreenWidth - 80 - circleWH,
                                   y: self.frame.size.height - circleWH - 15,
                                   width: circleWH,
                                   height: circleWH)

        makeCircleAnimate(imageView: circleOne, fromUp: true)
        makeCircleAnimate(imageView: circleTwo, fromUp: false)
        makeCircleAnimate(imageView: circleThree, fromUp: true)
    }

    func makeCircleAnimate(imageView: UIImageView, fromUp: Bool) {

        let y = imageView.center.y
        let x = imageView.center.x

        var maxMoveMargin: CGFloat = 0
        if fromUp == true {
            maxMoveMargin = 10
        } else {
            maxMoveMargin = -10
        }
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [
            NSValue(cgPoint: CGPoint(x: x, y: y)),
            NSValue(cgPoint: CGPoint(x: x, y: y - maxMoveMargin)),
            NSValue(cgPoint: CGPoint(x: x, y: y)),
            NSValue(cgPoint: CGPoint(x: x, y: y + maxMoveMargin)),
            NSValue(cgPoint: CGPoint(x: x, y: y)),
        ]
        animation.timingFunctions = [
            CAMediaTimingFunction(name: "easeOut"),
            CAMediaTimingFunction(name: "easeIn"),
            CAMediaTimingFunction(name: "easeOut"),
            CAMediaTimingFunction(name: "easeIn"),
        ]
        animation.autoreverses = false
        animation.duration = 4
        animation.repeatCount = MAXFLOAT
//        // 不知道为啥，延迟0.1秒后才能有这个动画 RN中
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            imageView.layer.add(animation, forKey: "circle move")
//        }
    }

    // MARK: - 三个云彩的动画
    func addCloudAnimate() {
        let cloudOne = createImageViewAndAddIt()
        let cloudOneW: CGFloat = 238
        let cloudOneH: CGFloat = 82
        cloudOne.image = UIImage.init(named: "LearnIntent_Cloud1")
        cloudOne.frame = CGRect(x: -cloudOneW,
                                y: 50,
                                width: cloudOneW,
                                height: cloudOneH)

        let cloudTwo = createImageViewAndAddIt()
        let cloudTwoW: CGFloat = 128
        let cloudTwoH: CGFloat = 38
        cloudTwo.image = UIImage.init(named: "LearnIntent_Cloud2")
        cloudTwo.frame = CGRect(x: ScreenWidth,
                                y: 0,
                                width: cloudTwoW,
                                height: cloudTwoH)

        let cloudThree = createImageViewAndAddIt()
        let cloudThreeW: CGFloat = 116
        let cloudThreeH: CGFloat = 68
        cloudThree.image = UIImage.init(named: "LearnIntent_Cloud3")
        cloudThree.frame = CGRect(x: ScreenWidth,
                                  y: self.frame.size.height - cloudThreeH,
                                  width: cloudThreeW,
                                  height: cloudThreeH)

        animateCloud(imageView: cloudOne, toLeft: false)
        animateCloud(imageView: cloudTwo, toLeft: true)
        animateCloud(imageView: cloudThree, toLeft: true)
    }

    func animateCloud(imageView: UIImageView, toLeft: Bool) {

        let thisViewWidth = imageView.frame.size.width
        let speed: CGFloat = 15
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = 0
        animation.toValue = toLeft ? -(ScreenWidth + thisViewWidth) : (ScreenWidth + thisViewWidth)
        animation.duration = CFTimeInterval((ScreenWidth + 2 * thisViewWidth) / speed)
        animation.repeatCount = MAXFLOAT
//        // 不知道为啥，延迟0.1秒后才能有这个动画 RN中
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
//        }
        imageView.layer.add(animation, forKey: "cloud move")
    }

    func createImageViewAndAddIt() -> UIImageView {
        let imageView = UIImageView()
        self.addSubview(imageView)
        return imageView
    }
}
