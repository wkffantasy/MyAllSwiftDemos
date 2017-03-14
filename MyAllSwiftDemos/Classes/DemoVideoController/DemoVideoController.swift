//
//  DemoVideoController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DemoVideoController: UIViewController {
    
    var player :WKFVideoPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        setupViews()
        
    }
    func setupViews() {
        let videoW = ScreenWidth
        let videoH = ScreenWidth * 0.6
        player = WKFVideoPlayerView.init(frame: CGRect(x:0,y:64,width:videoW,height:videoH))
        player.playUrl = "http://www.jxgbwlxy.gov.cn/tm/course/041629011/sco1/1.mp4"
        self.view.addSubview(player)
        
    }


}
