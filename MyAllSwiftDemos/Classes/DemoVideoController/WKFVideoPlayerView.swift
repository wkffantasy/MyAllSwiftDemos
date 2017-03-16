//
//  WKFVideoPlayerView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class WKFVideoPlayerView: UIView {

    typealias BoolParamBlock = (Bool) -> Void

    public var fullOrSmallBlock: BoolParamBlock?

    private var firstFrame: CGRect!
    private var topMenu: VideoTopMenu!
    private var bottomMenu: VideoBottomMenu!
    private var loadingView: UIActivityIndicatorView!
    private var player: WKFPlayer!

    var playUrl: String! {
        didSet {
            assert(playUrl.length > 0, "")
            log.verbose("give view url \(playUrl)")
            player.playUrl = playUrl
        }
    }

    var playTitle: String! {

        didSet {
            assert(playTitle.length > 0, "")
            log.verbose("give view title \(playTitle)")
            topMenu.playTitle = playTitle
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.clipsToBounds = true
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
        loadingView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }

    private func setupTopMenu() {
        topMenu = VideoTopMenu()
        self.addSubview(topMenu)
        topMenu.snp.makeConstraints { make in

            make.left.top.right.equalTo(0)
            make.height.equalTo(45)
        }
    }

    private func setupBottomMenu() {

        bottomMenu = VideoBottomMenu()
        bottomMenu.fullOrSmallBlock = { [weak self] willBeFull in

            if self?.fullOrSmallBlock != nil {
                self?.fullOrSmallBlock!(willBeFull)
            }
            if willBeFull == true {

                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                self?.frame = UIScreen.main.bounds

            } else {

                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                self?.frame = (self?.firstFrame)!
            }

            self?.player.updateThisLayerFrame(frame: (self?.bounds)!)
            self?.topMenu.relayoutThisLable(isFull: willBeFull)
        }
        bottomMenu.playOrPauseBlock = { [weak self] nowIsPlaying in
            if self?.loadingView.isHidden == false {
                return
            }
            self?.player.updatePlayerPauseAndPlay(isPlaying: nowIsPlaying)
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: nowIsPlaying)
        }
        self.addSubview(bottomMenu)
        bottomMenu.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(40)
        }
    }

    private func setupPlayer() {

        player = WKFPlayer.init(frame: self.bounds)
        player.PlayTotalTimeBlock = { [weak self] totalTime in

            self?.bottomMenu.updateTotalTime(thisTime: totalTime)
        }
        player.PlayStartSuccessBlock = { [weak self] in

            self?.loadingView.stopAnimating()
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: true)
        }
        player.PlayingCurrentTimeBlock = { [weak self] playCurrentTime in
            self?.bottomMenu.updateCurrentTime(thisTime: playCurrentTime)
        }
        player.PlayFailedBlock = {
            log.error("播放失败")
        }
        player.PlayLoadedTimeBlock = { [weak self] loadedTime in
            self?.bottomMenu.updateLoadedTime(thisTime: loadedTime)
        }
        player.PlayFinishedBlock = { [weak self] in
            log.verbose("================ PlayFinishedBlock")
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: false)
        }
        self.addSubview(player)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        log.warning("this video player view will be deinit")
    }
}
