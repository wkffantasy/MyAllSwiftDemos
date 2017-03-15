//
//  DemoVideoController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DemoVideoController: UIViewController {
    
    var playerView :WKFVideoPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        setupViews()
        
    }
    func setupViews() {
        let videoW = ScreenWidth
        let videoH = ScreenWidth * 0.6
        playerView = WKFVideoPlayerView.init(frame: CGRect(x:0,y:64,width:videoW,height:videoH))
        playerView.playTitle = "七里香"
//        player.playUrl = "http://www.jxgbwlxy.gov.cn/tm/course/041629011/sco1/1.mp4"
        playerView.playUrl = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
//        player.playUrl = "http://satic.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
        self.view.addSubview(playerView)
        
    }
    deinit {
        log.warning("this video controller will be deinit")
    }


}
