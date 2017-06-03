//
//  AnimateView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/25.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class AnimateView: UIView {

    typealias CallBackBlock = (Dictionary<String, String>) -> Void
    
    public var callBack: CallBackBlock?
    
    private var headerView:UIView!
    private var functionView:UIView!
    
    private let headerH :CGFloat = 300
    
    private let circleWH:CGFloat = 15.0
    private var circleOne:UIImageView!
    private var circleTwo:UIImageView!
    private var circleThree:UIImageView!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        print("init LearnIntentionView")
        backgroundColor = UIColor.white
        
        setupHeaderView()
        setupFuctionView()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeaderView() {
        headerView = UIView()
        headerView.backgroundColor = RGBColor(248,250,255)
        headerView.frame = CGRect(x:0,y:0,width:ScreenWidth,height:headerH)
        addSubview(headerView)
    
        addCircleAnimate()
        
    }
    func setupFuctionView() {
        functionView = UIView()
        functionView.backgroundColor = UIColor.white
        addSubview(functionView)
        functionView.frame = CGRect(x: 0, y: headerH, width: ScreenWidth, height: ScreenHeight - headerH)

    }
    
    // MARK: - 三个圆圈的动画
    func addCircleAnimate() {
        
        circleOne = createCircle(color:UIColor.red)
        circleOne.frame = CGRect(x: 30,
                                 y: headerView.center.y+30,
                                 width: circleWH,
                                 height: circleWH)
        
        circleTwo = createCircle(color:UIColor.blue)
        circleTwo.frame = CGRect(x: ScreenWidth - 70,
                                 y: 70,
                                 width: circleWH,
                                 height: circleWH)
        
        
        circleThree = createCircle(color:UIColor.green)
        circleThree.frame = CGRect(x: ScreenWidth - 30,
                                   y: headerView.center.y+30,
                                   width: circleWH,
                                   height: circleWH)
        
        makeCircleAnimate(imageView:circleOne,fromUp:true)
        makeCircleAnimate(imageView:circleTwo,fromUp:false)
        makeCircleAnimate(imageView:circleThree,fromUp:true)
        
    }
    
    func createCircle(color:UIColor) -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = color
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = circleWH / 2
        headerView.addSubview(imageView)
        return imageView
    }
    func makeCircleAnimate(imageView:UIImageView,fromUp:Bool) {
        
        let y = imageView.center.y
        let x = imageView.center.x
        
        var maxMoveMargin:CGFloat = 0
        if fromUp == true {
            maxMoveMargin = 10
        } else {
            maxMoveMargin = -10
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [
            NSValue(cgPoint: CGPoint(x:x, y:y)),
            NSValue(cgPoint: CGPoint(x:x, y:y - maxMoveMargin)),
            NSValue(cgPoint: CGPoint(x:x, y:y)),
            NSValue(cgPoint: CGPoint(x:x, y:y + maxMoveMargin)),
            NSValue(cgPoint: CGPoint(x:x, y:y)),
        ]
        
        /*
         `linear', `easeIn', `easeOut' and
         `easeInEaseOut' and `default'
         */
        animation.timingFunctions = [
            CAMediaTimingFunction(name: "easeOut"),
            CAMediaTimingFunction(name: "easeIn"),
            CAMediaTimingFunction(name: "easeOut"),
            CAMediaTimingFunction(name: "easeIn"),
        ]
        animation.autoreverses = false
        animation.duration = 4
        animation.repeatCount = MAXFLOAT
        imageView.layer.add(animation, forKey: "circle move")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
}
