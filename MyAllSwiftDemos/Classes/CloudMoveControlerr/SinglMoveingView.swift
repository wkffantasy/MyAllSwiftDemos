//
//  SinglMoveingView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/6/3.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class SinglMoveingView: UIView {
    private var toLeft:Bool!
    private var imageName:String!
    private var containerView:UIView!
    
    let speed: CGFloat = 20
    
    init(frame:CGRect,
         toLeft:Bool,
         imageName:String
        )
    {
        super.init(frame:frame)
        
        assert(imageName.length > 0,"")
        assert(frame != .zero,"")
        
        self.imageName = imageName
        self.toLeft = toLeft
        
        setupSubviews()
    
        animateIt()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupSubviews() {
        let thisImage = UIImage.init(named: imageName)
        containerView = UIView()
        let containerViewW = (thisImage?.size.width)!+ScreenWidth
        let containerViewH = (thisImage?.size.height)!
        var x:CGFloat = 0
        if toLeft == false {
            x = -ScreenWidth
        } else {
            x = ScreenWidth - (thisImage?.size.width)!
        }
        containerView.frame = CGRect(x:x ,
                                     y: 0,
                                     width: containerViewW,
                                     height:containerViewH)
        addSubview(containerView)
        
        setupImageView(tag: 0)
        setupImageView(tag: 1)
        
    }
    func setupImageView(tag:Int) {
        let thisImage = UIImage.init(named: imageName)
        let imageView = UIImageView()
        imageView.tag = tag
        imageView.image = thisImage
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(tag == 0 ? 0 : ScreenWidth)
        }

    }
    func animateIt() {
        
        let thisViewWidth = UIImage.init(named: imageName)?.size.width
        let duration = CFTimeInterval((ScreenWidth + 2 * thisViewWidth!) / speed)

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = 0
        animation.duration = duration
        animation.repeatCount = MAXFLOAT
        
        if toLeft == false {
            animation.toValue = ScreenWidth
        } else {
            animation.toValue = -ScreenWidth
        }
        DispatchQueue.main.async {
            self.containerView.layer.add(animation, forKey: "cloud move")
        }
    }
 


}
