//
//  AnimateMoveView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/6/3.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class AnimateMoveView: UIView {

    override init(frame:CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        addSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        let cloud2Image = UIImage.init(named: "LearnIntent_Cloud2")
        let cloud2View = SinglMoveingView.init(
            frame: CGRect(x:0,y:0,width:ScreenWidth,height:(cloud2Image?.size.height)!),
            toLeft: true,
            imageName: "LearnIntent_Cloud2")
        addSubview(cloud2View)
        
        
        let cloud1Image = UIImage.init(named: "LearnIntent_Cloud1")
        let cloud1View = SinglMoveingView.init(
            frame: CGRect(x:0,y:(cloud2Image?.size.height)!+10,width:ScreenWidth,height:(cloud1Image?.size.height)!),
            toLeft: false,
            imageName: "LearnIntent_Cloud1")
        addSubview(cloud1View)
        
        
        let cloud3Image = UIImage.init(named: "LearnIntent_Cloud3")
        let cloud3View = SinglMoveingView.init(
            frame: CGRect(x:0,y:200,width:ScreenWidth,height:(cloud3Image?.size.height)!),
            toLeft: true,
            imageName: "LearnIntent_Cloud3")
        addSubview(cloud3View)

    }

}

