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
        
        setupTopMenu()
        
        setupBottomMenu()
        
        loadingView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        loadingView.hidesWhenStopped = true
        loadingView.startAnimating()
        self.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
   
    }
    private func setupTopMenu(){
        topMenu = VideoTopMenu()
        self.addSubview(topMenu)
        topMenu.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(40)
        }
    }
    private func setupBottomMenu(){
        
        bottomMenu = VideoBottomMenu()
        bottomMenu.fullOrSmallBlock = {(willBeFull) in
            log.verbose("fullOrSmallBlock == \(willBeFull)")
            
        }
        bottomMenu.playOrPauseBlock = {[weak self](nowIsPlaying) in
            
            self?.player.updatePlayerPauseAndPlay(isPlaying: nowIsPlaying)
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: nowIsPlaying)
            
        }
        self.addSubview(bottomMenu)
        bottomMenu.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(40)
        }
    
    }

    private func setupPlayer(){
    
        player = WKFPlayer.init(frame: self.bounds)
        player.PlayTotalTimeBlock = { [weak self] totalTime in
            log.verbose("totalTime == \(totalTime)")
            self?.bottomMenu.updateTotalTime(thisTime: totalTime)
        }
        player.PlayStartSuccessBlock = {  [weak self] in
            if self?.loadingView.isHidden == false {
                return
            }
            self?.loadingView.stopAnimating()
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: true)
        }
        player.PlayingCurrentTimeBlock = { [weak self]playCurrentTime in
            log.verbose("playCurrentTime ==\(playCurrentTime)")
            self?.bottomMenu.updateCurrentTime(thisTime: playCurrentTime)
        }
        player.PlayFailedBlock = {
            log.error("播放失败")
        }
        player.PlayLoadedTimeBlock = { [weak self]loadedTime in
            log.verbose("loaded time =\(loadedTime)")
            self?.bottomMenu.updateLoadedTime(thisTime: loadedTime)
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
