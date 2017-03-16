//
//  DemoVideoController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DemoVideoController: UIViewController {

    let url1 = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
    let url2 = "http://www.jxgbwlxy.gov.cn/tm/course/041629011/sco1/1.mp4"
    // this url3 is an error url
    let url3 = "http://satic.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"

    var playerView: WKFVideoPlayerView!
    var isFull: Bool! = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        setupViews()
    }

    func setupViews() {
        let videoW = ScreenWidth
        let videoH = ScreenWidth * 0.6
        playerView = WKFVideoPlayerView.init(frame: CGRect(x: 0, y: 64, width: videoW, height: videoH))
        playerView.fullOrSmallBlock = { [weak self] willBeFull in

            self?.navigationController?.setNavigationBarHidden(willBeFull, animated: true)
            self?.isFull = willBeFull
            self?.setNeedsStatusBarAppearanceUpdate()
        }
        playerView.playTitle = "七里香"
        playerView.playUrl = url1
        self.view.addSubview(playerView)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.isFull == true ? .lightContent : .default
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    deinit {
        log.warning("this video controller will be deinit")
    }
}
