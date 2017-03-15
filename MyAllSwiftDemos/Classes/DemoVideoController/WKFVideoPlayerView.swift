//
//  WKFVideoPlayerView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class WKFVideoPlayerView: UIView {
    
    private var firstFrame :CGRect!
    
    private var topMenu:VideoTopMenu!
    private var bottomMenu:VideoBottomMenu!
    private var loadingView :UIActivityIndicatorView!
    private var player:WKFPlayer!
    
    
    var playUrl:String! {
        didSet {
            assert(playUrl.length > 0,"")
            log.verbose("give view url \(playUrl)")
            player.playUrl = playUrl
        }
        
    }
    var playTitle:String! {
        
        didSet{
            assert(playTitle.length > 0,"")
            log.verbose("give view title \(playTitle)")
            topMenu.playTitle = playTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        firstFrame = frame
        setupViews()
        
    }
    private func setupViews() {
        
        setupPlayer()
        
        topMenu = VideoTopMenu()
        self.addSubview(topMenu)
        topMenu.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        bottomMenu = VideoBottomMenu()
        self.addSubview(bottomMenu)
        bottomMenu.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(40)
        }
        
        loadingView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        loadingView.hidesWhenStopped = true
        loadingView.startAnimating()
        self.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
   
    }
    private func setupPlayer(){
    
        player = WKFPlayer.init(frame: self.bounds)
        player.PlayTotalTimeBlock = {  totalTime in
            log.verbose("totalTime == \(totalTime)")
        }
        player.PlayStartSuccessBlock = {  [weak self] in
            self?.loadingView.stopAnimating()
            log.verbose("PlayStartSuccessBlock")
        }
        player.PlayingCurrentTimeBlock = { playCurrentTime in
            log.verbose("playCurrentTime ==\(playCurrentTime)")
        }
        player.PlayFailedBlock = {
            log.error("播放失败")
        }
        player.PlayLoadedTimeBlock = { loadedTime in
            log.verbose("loaded time =\(loadedTime)")
        }
        player.PlayFinishedBlock = {
            log.verbose("================ PlayFinishedBlock")
        }
        self.addSubview(player)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        log.warning("this video player view will be deinit")
    }
    
   

}
