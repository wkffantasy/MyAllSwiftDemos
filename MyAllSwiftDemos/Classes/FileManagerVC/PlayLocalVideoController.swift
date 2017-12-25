//
//  PlayLocalVideoController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/11.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class PlayLocalVideoController: UIViewController {

    var localUrl: String!
    var name: String!
    var playerView: WKFVideoPlayerView!
    var isFull: Bool! = false

    init(localUrl: String, name: String) {
        super.init(nibName: nil, bundle: nil)
        self.localUrl = localUrl
        self.name = name
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        playerView.playTitle = name
        playerView.playUrl = localUrl
        self.view.addSubview(playerView)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.isFull == true ? .lightContent : .default
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    deinit {
        // add this to avoid player deinit in a delay
        playerView.removeThisView()
//        log.warning("this video controller will be deinit")
    }
}
