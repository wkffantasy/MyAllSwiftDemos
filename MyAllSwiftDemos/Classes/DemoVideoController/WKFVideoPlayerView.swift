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
            log.verbose("==================开始播放")
            self?.loadingView.stopAnimating()
            self?.bottomMenu.updatePauseAndPlayStatus(isPlaying: true)
        }
        player.PlayingCurrentTimeBlock = { [weak self] playCurrentTime in
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
        self.addSubview(player)
        addGesturesAction()
        addTimer()
    }

    private func addGesturesAction() {

        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureTaped(tap:)))
        player.addGestureRecognizer(tapGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesturePaned(pan:)))
        player.addGestureRecognizer(panGesture)
    }

    @objc private func panGesturePaned(pan: UIPanGestureRecognizer) {

        let locationPoint = pan.location(in: self)
        let velocityPoint = pan.velocity(in: self)
        switch pan.state {
        case .began:
            let x = fabs(velocityPoint.x)
            let y = fabs(velocityPoint.y)
            if x > y { // 进度
                panDirection = .panHorizontal
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
            print("changed panDirection == \(panDirection)")
            if panDirection == .panHorizontal {

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
            }
        default:
            break
        }
    }

    @objc private func tapGestureTaped(tap _: UITapGestureRecognizer) {
        log.warning("tapGestureTaped ==\(nowIsShowMenuView)")
        if !nowIsShowMenuView {
            addTimer()
        }
        hideOrShowMenuViews(isShow: nowIsShowMenuView)
    }

    private func hideOrShowMenuViews(isShow _: Bool) {
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
            self.hideOrShowMenuViews(isShow: true)
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
