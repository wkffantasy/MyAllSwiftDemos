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
    private var nowIsShowMenuView: Bool = true
    private let appearMenuTime = 5.0
    private var timer: Timer?
    private var panDirection: PanDirection? = PanDirection.panHorizontal
    private var panVolumeOrBright: PanVolumeOrBrightness? = PanVolumeOrBrightness.panVolume
    private var thisCurrentTime: Float = -1
    private var thisTotalTime: Float = -1
    private var nowIsPan: Bool = false
    private var panCurrentTime: Float = 0

    var playUrl: String! {
        didSet {
            assert(playUrl.length > 0, "")
            log.verbose("give view url \(playUrl)")
            player.playUrl = playUrl
        }
    }

    public func removeThisView() {
        removeTimer(timer: timer!)
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
            self?.removeTimer(timer: (self?.timer!)!)
            self?.addTimer()
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
            self?.removeTimer(timer: (self?.timer!)!)
            self?.addTimer()
            self?.player.updatePlayerPauseAndPlay(isPlaying: nowIsPlaying)
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: nowIsPlaying)
        }
        bottomMenu.beganPanBlock = { [weak self] pan in
            self?.paningGesture(pan: pan, canMoveUpAndDown: true)
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
            self?.thisTotalTime = totalTime
            self?.bottomMenu.updateTotalTime(thisTime: totalTime)
        }
        player.PlayStartSuccessBlock = { [weak self] in
            log.verbose("==================开始播放")
            self?.loadingView.stopAnimating()
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: true)
        }
        player.PlayingCurrentTimeBlock = { [weak self] playCurrentTime in
            if self?.nowIsPan == true { return }
            self?.thisCurrentTime = playCurrentTime
            self?.bottomMenu.updateCurrentTime(thisTime: playCurrentTime)
        }
        player.PlayFailedBlock = {
            log.error("==================播放失败")
        }
        player.PlayLoadedTimeBlock = { [weak self] loadedTime in
            self?.bottomMenu.updateLoadedTime(thisTime: loadedTime)
        }
        player.PlayFinishedBlock = { [weak self] in
            log.verbose("================ 播放完成")
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: false)
        }
        player.BufferEmptyBlock = { [weak self] in
            print("*******************BufferEmptyBlock")
            self?.loadingView.startAnimating()
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: false)
        }
        player.BufferLikelyToPlayBlock = { [weak self] in
            print("!!!!!!!!!!!!!!!!!!!!! BufferLikelyToPlayBlock")
            if self?.nowIsPan == true { return }
            self?.loadingView.stopAnimating()
            self?.player.updatePlayerPauseAndPlay(isPlaying: true)
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: true)
        }
        self.addSubview(player)
        addGesturesAction()
        addTimer()
    }
 

    private func addGesturesAction() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureTaped(tap:)))
        player.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesturePaned(pan:)))
        self.addGestureRecognizer(panGesture)
    }

    private func paningGesture(pan: UIPanGestureRecognizer, canMoveUpAndDown moveUp: Bool) {

        let locationPoint = pan.location(in: self)
        let velocityPoint = pan.velocity(in: self)
        let translationPoint = pan.translation(in: self)
        switch pan.state {
        case .began:
            if moveUp == true {
                panDirection = .panHorizontal
                removeTimer(timer: timer!)
                nowIsShowMenuView = false
                hideOrShowMenuViews()
                break
            }
            let x = fabs(velocityPoint.x)
            let y = fabs(velocityPoint.y)
            if x > y { // 进度
                panDirection = .panHorizontal
                nowIsPan = true
                bottomMenu.updatePauseAndPlayStatus(isPlaying: false)
                player.updatePlayerPauseAndPlay(isPlaying: false)
                removeTimer(timer: timer!)
                nowIsShowMenuView = false
                hideOrShowMenuViews()
            } else { // 声音与亮度
                panDirection = .panVertical
                if locationPoint.x > self.bounds.size.width / 2 {
                    // 声音
                    panVolumeOrBright = .panVolume
                } else {
                    // 亮度
                    panVolumeOrBright = .panBrightness
                }
            }
        case .changed:
            if panDirection == .panHorizontal {
                let thisViewLineWidth = bottomMenu.getViewLineWidth()

                if thisCurrentTime != -1 && thisTotalTime != -1 && thisViewLineWidth > CGFloat(0) {

                    panCurrentTime = Float(translationPoint.x) * thisTotalTime / Float(thisViewLineWidth) + thisCurrentTime
                    if panCurrentTime > thisTotalTime {
                        panCurrentTime = thisTotalTime - 1
                    } else if panCurrentTime < Float(0) {
                        panCurrentTime = 0
                    }
                    player.seekToTime(seconds: panCurrentTime)
                    bottomMenu.updateCurrentTime(thisTime: panCurrentTime)
                }
            } else {
                if panVolumeOrBright == .panVolume { // volume
                    player.updatePlayerVolume(volume: Float(velocityPoint.y) / 5000.0)
                } else { // brightness
                    UIScreen.main.brightness -= velocityPoint.y / 10000.0
                }
            }
        case .ended:
            print("ended panDirection==\(panDirection)")
            if panDirection == .panHorizontal {
                nowIsPan = false
                addTimer()
                thisCurrentTime = panCurrentTime
                panCurrentTime = 0
            }
            if !playUrl.hasPrefix("http") {
                // 播放本地的 快进快退后 要播放
                player.updatePlayerPauseAndPlay(isPlaying: true)
                bottomMenu.updatePauseAndPlayStatus(isPlaying: true)
            }

        default:
            break
        }
    }

    @objc private func panGesturePaned(pan: UIPanGestureRecognizer) {
        paningGesture(pan: pan, canMoveUpAndDown: false)
    }

    @objc private func tapGestureTaped(tap _: UITapGestureRecognizer) {
        log.warning("tapGestureTaped ==\(nowIsShowMenuView)")
        if !nowIsShowMenuView {
            addTimer()
        }
        hideOrShowMenuViews()
    }

    private func hideOrShowMenuViews() {
        UIView.animate(withDuration: 1.0, animations: {
            self.topMenu.isHidden = self.nowIsShowMenuView
            self.bottomMenu.isHidden = self.nowIsShowMenuView
        }) { _ in
            self.nowIsShowMenuView = !self.nowIsShowMenuView
        }
    }

    private func addTimer() {
        if timer != nil {
            removeTimer(timer: timer!)
        }
        timer = Timer.scheduledTimer(timeInterval: appearMenuTime, target: self, selector: #selector(hideMenusWithTimer(thisTimer:)), userInfo: nil, repeats: false)
    }

    @objc private func hideMenusWithTimer(thisTimer: Timer) {
        if thisTimer == timer && nowIsShowMenuView {
            self.hideOrShowMenuViews()
            removeTimer(timer: thisTimer)
        }
    }

    private func removeTimer(timer: Timer) {
        timer.invalidate()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeTimer(timer: timer!)
        log.warning("this video player view will be deinit")
    }
}
