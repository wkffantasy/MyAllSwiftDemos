//
//  WKFPlayer.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

import AVFoundation

class WKFPlayer: UIView {

    var player :AVPlayer!
    var filePath:NSURL!
    var playerItem:AVPlayerItem!
    var videoURLAsset:AVURLAsset!
    var playerLayer:AVPlayerLayer!
    
    var playUrl:String! {
        
        didSet {
            log.verbose("give player url \(playUrl)")
            initPlayer()
        }
        
    }
    private func initPlayer(){
        
        if player != nil {
            player = nil
            removeObservers()
        }
        
        fileExistsAtPath(url:playUrl)
        
        videoURLAsset = AVURLAsset.init(url: filePath as URL)
        playerItem = AVPlayerItem.init(asset: videoURLAsset)
        if (player != nil && player.currentItem != nil) {
            player.replaceCurrentItem(with: playerItem)
        } else {
            player = AVPlayer.init(playerItem: playerItem)
        }
        playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.frame = self.bounds
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientChange(noti:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    //判断是否存在已下载好的文件
    private func fileExistsAtPath(url:String){
        
        //TODO:
        filePath = NSURL.init(string: url)
    
    }
    
    
    func orientChange(noti:NSNotification) {
        log.verbose("orientChange ","noti")
    }
    
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    deinit {
        removeObservers()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
