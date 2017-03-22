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
    private var circleView:UIView!
    private var itemArray:Array<SliderItem>!
    private var startAngel:CGFloat!
    private var itemSize = CGSize(width:50,height:70)
    
    init(frame: CGRect,
         titleArray:Array<String>,
         imageNameArray:Array<String>)
    {
        super.init(frame: frame)
        assert(frame.size.width == frame.size.height,"")
        assert(titleArray.count>1,"")
        assert(imageNameArray.count>1,"")
        self.imageNameArray = imageNameArray
        self.titleArray = titleArray
        itemArray = []
        startAngel = CGFloat(M_PI / 2.0)
        
        circleView = UIView(frame: self.bounds)
        circleView.backgroundColor = UIColor.white
        circleView.layer.masksToBounds = true
        circleView.layer.cornerRadius = frame.size.width/2
        addSubview(circleView)
        
        addCenterCircleView()
        addRoundItems()
        
    }
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
    }
    private func layoutItems(){
        assert(itemArray.count == titleArray.count,"")
        
        let radius = self.frame.size.width / 2
        let itemWidth:CGFloat = itemSize.width
        let totalCount = titleArray.count
        for index in 0 ..< totalCount {
            let item:SliderItem = itemArray[index]
            
            let yy = radius+CGFloat(radius-itemWidth/2-20)*sin(CGFloat(index)/CGFloat(totalCount)*2*CGFloat(M_PI)+startAngel)
            let xx = radius+CGFloat(radius-itemWidth/2-20)*cos(CGFloat(index)/CGFloat(totalCount)*2*CGFloat(M_PI)+startAngel)
            print("index ==",index)
            print("yy ==",yy)
            print("xx ==",xx)
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
