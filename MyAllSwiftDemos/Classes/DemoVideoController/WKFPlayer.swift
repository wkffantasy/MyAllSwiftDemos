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

    typealias FloatParamBlock = (Float) -> Void
    typealias NoParamBlock = () -> Void
    typealias BoolParamBlock = (Bool) -> Void

    // 总时长的回调
    public var PlayTotalTimeBlock: FloatParamBlock?

    // 开始播放成功的回调
    public var PlayStartSuccessBlock: NoParamBlock?

    // 播放失败的回调
    public var PlayFailedBlock: NoParamBlock?

    // 正在播放的当前时间的回调
    public var PlayingCurrentTimeBlock: FloatParamBlock?

    // 已经加载视频时间的回调
    public var PlayLoadedTimeBlock: FloatParamBlock?

    // 播放完成的回调
    public var PlayFinishedBlock: NoParamBlock?

    // 方向改变(全屏小屏)回调
    public var PlayDirectionBlock: BoolParamBlock?

    // 播放停止的回调
    public var PlayStopBlock: NoParamBlock?

    // 播放暂停的回调
    public var PlayPauseBlock: NoParamBlock?

    // 缓存区 空了需要等待
    public var BufferEmptyBlock: NoParamBlock?

    // 有足够的缓存 可以播放了
    public var BufferLikelyToPlayBlock: NoParamBlock?

    private var player: AVPlayer!
    private var filePath: NSURL!
    private var playerItem: AVPlayerItem!
    private var videoURLAsset: AVURLAsset!
    private var playerLayer: AVPlayerLayer!
    private var timeObserver: AnyObject!

    var playUrl: String! {

        didSet {
            log.verbose("give player url \(playUrl)")
            initPlayer()
        }
    }

    public func updateThisLayerFrame(frame: CGRect) {
        self.frame = frame
        playerLayer.frame = frame
    }

    public func updatePlayerPauseAndPlay(isPlaying: Bool) {

        if isPlaying != true {
            player.pause()
        } else {
            player.play()
        }
    }

    public func updatePlayerVolume(volume: Float) {
        player.volume -= volume
    }

    private func initPlayer() {

        if player != nil {
            player = nil
            removeObservers()
        }

        fileExistsAtPath(url: playUrl)

        videoURLAsset = AVURLAsset.init(url: filePath as URL)
        playerItem = AVPlayerItem.init(asset: videoURLAsset)
        if player != nil && player.currentItem != nil {
            player.replaceCurrentItem(with: playerItem)
        } else {
            player = AVPlayer.init(playerItem: playerItem)
        }
        playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.frame = self.bounds
        self.layer.insertSublayer(playerLayer, at: 0)
        player.volume = 0.5
        player.play()
        // 缓冲区空了，需要等待数据
        playerItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        // 缓冲区有足够数据可以播放了
        playerItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)

        playerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playerFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }

    override func observeValue(forKeyPath keyPath: String?, of sth: Any?, change thisChange: [NSKeyValueChangeKey: Any]?, context thisContext: UnsafeMutableRawPointer?) {

        if keyPath == "status" {
            observeForStatus()
        } else if keyPath == "loadedTimeRanges" {
            observeForLoadedTimeRanges()
        } else if keyPath == "playbackBufferEmpty" {
            if self.BufferEmptyBlock != nil {
                self.BufferEmptyBlock!()
            }
        } else if keyPath == "playbackLikelyToKeepUp" {
            if self.BufferLikelyToPlayBlock != nil {
                self.BufferLikelyToPlayBlock!()
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: sth, change: thisChange, context: thisContext)
        }
    }

    private func callBackTotalTime() {
        let duration = playerItem.duration
        let totalSecond: Float64 = CMTimeGetSeconds(duration)
        if self.PlayTotalTimeBlock != nil {
            self.PlayTotalTimeBlock!(Float(totalSecond))
        }
    }

    private func observeForStatus() {

        if playerItem.status == .readyToPlay {

            callBackTotalTime()

            if self.PlayStartSuccessBlock != nil {
                self.PlayStartSuccessBlock!()
            }

            if self.PlayingCurrentTimeBlock != nil {
                self.PlayingCurrentTimeBlock!(getCurrentTime())
            }

            let timeInterval: CMTime = CMTimeMakeWithSeconds(1.0, 10)
            timeObserver = player.addPeriodicTimeObserver(forInterval: timeInterval, queue: DispatchQueue.main, using: { [weak self] _ in

                if self?.PlayingCurrentTimeBlock != nil {
                    self?.PlayingCurrentTimeBlock!((self?.getCurrentTime())!)
                }

            }) as AnyObject!

        } else { // failed and unknown
            if self.PlayFailedBlock != nil {
                self.PlayFailedBlock!()
            }
        }
    }

    private func observeForLoadedTimeRanges() {

        let timeInterval = playerAvalableDuration()
        DispatchQueue.main.async {
            if self.PlayLoadedTimeBlock != nil {
                self.PlayLoadedTimeBlock!(Float(timeInterval))
            }
        }
    }

    // 计算缓冲区的时间
    private func playerAvalableDuration() -> TimeInterval {
        let loadedTimeArray = player.currentItem?.loadedTimeRanges
        let timeRange = loadedTimeArray?.first?.timeRangeValue

        return CMTimeGetSeconds((timeRange?.start)!) + CMTimeGetSeconds((timeRange?.duration)!)
    }

    // 视频播放完成之后
    @objc private func playerFinished() {

        if self.PlayFinishedBlock != nil {
            self.PlayFinishedBlock!()
        }
    }

    private func getCurrentTime() -> Float {
        let currentSecond: Float = Float(playerItem.currentTime().value) / Float(playerItem.currentTime().timescale)
        return currentSecond
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
    }

    // 判断是否存在已下载好的文件
    private func fileExistsAtPath(url: String) {

        // TODO:
        filePath = NSURL.init(string: url)
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
        playerItem.removeObserver(self, forKeyPath: "status")
        playerItem.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        playerItem.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        playerItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }

    deinit {

        removeObservers()
        log.warning("this player will be deinit")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
