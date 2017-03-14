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
            log.verbose("give view url \(playUrl)")
            player.playUrl = playUrl
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        firstFrame = frame
        setupViews()
        
    }
    private func setupViews() {
        
        player = WKFPlayer.init(frame: self.bounds)
        self.addSubview(player)
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

}
