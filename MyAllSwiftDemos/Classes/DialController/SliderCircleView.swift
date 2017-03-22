//
//  SliderCircleView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class SliderCircleView: UIView {
    
    public var clickItemTag:IntParamBlock?
    
    private var titleArray:Array<String>!
    private var imageNameArray:Array<String>!
    private var circleView:CircleView!
    private var itemArray:Array<SliderItem>!
    private var kStartAngel:CGFloat!
    private var itemSize = CGSize(width:50,height:70)
    private var beganPoint :CGPoint = .zero
    private var movePoint :CGPoint = .zero
    
    init(frame: CGRect,
         titleArray:Array<String>,
         imageNameArray:Array<String>)
    {
        super.init(frame: frame)
        assert(frame.size.width == frame.size.height,"")
        assert(titleArray.count>1,"")
        assert(imageNameArray.count>1,"")
        backgroundColor = UIColor.yellow
        self.imageNameArray = imageNameArray
        self.titleArray = titleArray
        itemArray = []
        kStartAngel = CGFloat(M_PI / 2.0)
        
        circleView = CircleView.init(frame: self.bounds, totalCount: titleArray.count)
        addSubview(circleView)
        
//        addCenterCircleView()
//        addRoundItems()
        
        
    }
//    override func draw(_ rect: CGRect) {
//        let totalCount = titleArray.count
//        let marginAngle:CGFloat = CGFloat(M_PI) * 2 / CGFloat(totalCount)
//        let halfMarginAngle = marginAngle / 2
//        let radius = self.frame.size.width / 2
//        assert(totalCount>1,"")
//        for index in 0..<totalCount {
//            print("index ==",index)
//            let SinX = radius*sin(halfMarginAngle+CGFloat(index)*marginAngle)
//            let CosY = radius*cos(halfMarginAngle+CGFloat(index)*marginAngle)
//            print("SinX ==",SinX)
//            print("CosY ==",CosY)
//            let beganX = radius + SinX
//            let beganY = radius + CosY
//            let endX = radius+SinX/2
//            let endY = radius+CosY/2
//            
//            let path = UIBezierPath()
//            UIColor.colorWithRGB(red: 52, green: 146, blue: 244).setFill()
//            path.move(to: CGPoint(x:beganX,y:beganY))
//            path.addLine(to: CGPoint(x:endX,y:endY))
//            path.lineWidth = 2.0
//            path.fill()
//            
////            var beganX:CGFloat = 0
////            var beganY:CGFloat = 0
////            var endX :CGFloat = 0
////            var endY :CGFloat = 0
////            if index < totalCount/2 {
////                beganX = radius - SinX
////                endX = radius - SinX/3
////            } else {
////                beganX = radius + SinX
////                endX = radius + SinX/3
////            }
//            
//        }
//    }
//    private func getQuadrantAccordingIndex(index:Int)->Int{
//        let totalCount = titleArray.count
//        if index < totalCount/2 {
//        
//        } else {
//        
//        }
//    }
    private func addCenterCircleView(){
        
        let bigWidth = ScreenWidth/2 - 40
        let smallWidth = bigWidth - 20
        let bigCircleView = UIView()
        bigCircleView.backgroundColor = UIColor.colorWithRGB(red: 94, green: 178, blue: 248)
        bigCircleView.layer.masksToBounds = true
        bigCircleView.layer.cornerRadius = bigWidth / 2
        addSubview(bigCircleView)
        bigCircleView.snp.makeConstraints { (make) in
            make.width.height.equalTo(bigWidth)
            make.center.equalTo(self.snp.center)
        }
        
        let smallCircle = UIView()
        smallCircle.backgroundColor = UIColor.colorWithRGB(red: 52, green: 146, blue: 244)
        smallCircle.layer.masksToBounds = true
        smallCircle.layer.cornerRadius = smallWidth / 2
        addSubview(smallCircle)
        smallCircle.snp.makeConstraints { (make) in
            make.width.height.equalTo(smallWidth)
            make.center.equalTo(self.snp.center)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "依然Fantasy\nJay"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.width.height.lessThanOrEqualTo(smallWidth)
        }
        
    }
    private func addRoundItems(){
        assert(circleView != nil,"")
        var tag = 0
        for title in titleArray {
            let item = SliderItem.init(frame: CGRect(x:0,y:0,width:itemSize.width,height:itemSize.height), title: title, imageName: imageNameArray[tag])
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickThisItem(tap:)))
            item.addGestureRecognizer(tap)
            item.tag = tag
            circleView.addSubview(item)
            itemArray.append(item)
            tag += 1
        }
        layoutItems()
        addPanGesture()
        
    }
    private func addPanGesture(){
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(paning(pan:)))
        circleView.addGestureRecognizer(pan)
    }
    func paning(pan:UIPanGestureRecognizer) {
        
        switch pan.state {
        case .began:
            beganPoint = pan.location(in: self)
        case .changed:
            movePoint = pan.location(in: self)
//            print("movePoint ==",movePoint)
            let startAngle = getAngle(point: beganPoint)
            let moveAngle = getAngle(point: movePoint)
            print("startAngle==",startAngle,"moveAngle ==",moveAngle)
            if getQuadrant(point: movePoint) == 1 || getQuadrant(point: movePoint) == 4 {
                kStartAngel = kStartAngel+moveAngle - startAngle
                print("第一、四象限")
            } else {
                kStartAngel = kStartAngel+startAngle - moveAngle
                print("第二、三象限")
            }
            
            layoutItems()
            beganPoint = movePoint
            
        case .ended:
            print("end")
        default: break
        }
    }
    private func getQuadrant(point:CGPoint)->Int{
        let x =  Int(point.x - self.frame.size.width / 2)
        let y =  Int(point.y - self.frame.size.width / 2)
        if x >= 0 {
            return y>=0 ? 1 : 4
        } else {
            return y>=0 ? 2 : 3
        }
    }
    private func getAngle(point:CGPoint) -> CGFloat{
        let x =  point.x - self.frame.size.width / 2
        let y =  point.y - self.frame.size.width / 2
        return asinh(y/hypot(x, y))
    }
    private func layoutItems(){
        assert(itemArray.count == titleArray.count,"")
        let radius = self.frame.size.width / 2
        let itemWidth:CGFloat = itemSize.width
        let totalCount = titleArray.count
        for index in 0 ..< totalCount {
            let item:SliderItem = itemArray[index]
            let yy = radius+CGFloat(radius-itemWidth/2-20)*sin(CGFloat(index)/CGFloat(totalCount)*2*CGFloat(M_PI)+kStartAngel)
            let xx = radius+CGFloat(radius-itemWidth/2-20)*cos(CGFloat(index)/CGFloat(totalCount)*2*CGFloat(M_PI)+kStartAngel)
            item.center = CGPoint(x:xx,y:yy)
        }
    }
    @objc private func clickThisItem(tap:UITapGestureRecognizer){
        let tag = tap.view?.tag
        print("clickThisItem tag ==",tag ?? -1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
