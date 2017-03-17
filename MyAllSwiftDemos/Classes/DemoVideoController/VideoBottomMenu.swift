//
//  VideoBottomMenu.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class VideoBottomMenu: UIView {

    let buttonWH = 20

    typealias BoolParamBlock = (Bool) -> Void
    typealias PanGestureParamBlock = (UIPanGestureRecognizer) -> Void

    public var fullOrSmallBlock: BoolParamBlock?
    public var playOrPauseBlock: BoolParamBlock?
    public var beganPanBlock:PanGestureParamBlock?

    private var buttonPlay: UIButton!
    private var labelCurrentTime: UILabel!
    private var labelTotalTime: UILabel!
    private var viewLine: UIView!
    private var viewLoadedLine: UIView!
    private var viewCurrentLine: UIView!
    private var buttonFullScreen: UIButton!

    private var totalTime: Float?
    private var currentTime: Float?

    private var nowIsFull: Bool = false
    private var nowIsPlaying: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorWithHexString("000000", Alpha: 0.7)
        setupViews()
    }

    public func getViewLineWidth() -> CGFloat {
        return viewLine.frame.size.width
    }

    public func updateTotalTime(thisTime: Float) {
        totalTime = thisTime
        let thisString = TimeTool.tool.convertTimeIntToTimeString(time: Int64(thisTime))
        labelTotalTime.text = "/ " + thisString
    }

    public func updatePauseAndPlayStatus(isPlaying: Bool) {

        self.nowIsPlaying = isPlaying
        if isPlaying == true {
            buttonPlay.setImage(UIImage.init(named: "nowPlayingStatus"), for: .normal)
        } else {
            buttonPlay.setImage(UIImage.init(named: "nowPauseStatus"), for: .normal)
        }
    }

    public func updateLoadedTime(thisTime: Float) {
        if totalTime == nil {
            return
        }
        viewLoadedLine.snp.remakeConstraints { make in
            make.left.equalTo(viewLine.snp.left)
            make.height.equalTo(2)
            make.width.equalTo(viewLine.snp.width).multipliedBy(thisTime / totalTime!)
            make.centerY.equalTo(viewLine.snp.centerY)
        }
    }

    public func updateCurrentTime(thisTime: Float) {
        currentTime = thisTime
        if totalTime == nil {
            return
        }
        let thisString = TimeTool.tool.convertTimeIntToTimeString(time: Int64(thisTime))
        labelCurrentTime.text = thisString

        viewCurrentLine.snp.remakeConstraints { make in
            make.left.equalTo(viewLine.snp.left)
            make.height.equalTo(3)
            make.width.equalTo(viewLine.snp.width).multipliedBy(thisTime / totalTime!)
            make.centerY.equalTo(viewLine.snp.centerY)
        }
    }

    private func setupViews() {

        // 暂停 播放的按钮
        buttonPlay = UIButton.init(type: .custom)
        buttonPlay.setImage(UIImage.init(named: "nowPauseStatus"), for: .normal)
        buttonPlay.addTarget(self, action: #selector(clickPlayButton(button:)), for: .touchUpInside)
        self.addSubview(buttonPlay)
        buttonPlay.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(buttonWH)
            make.left.equalTo(20)
        }

        // 全屏 小屏
        buttonFullScreen = UIButton.init(type: .custom)
        buttonFullScreen.setImage(UIImage.init(named: "nowSmallScreen"), for: .normal)
        buttonFullScreen.addTarget(self, action: #selector(clickFullButton(button:)), for: .touchUpInside)
        self.addSubview(buttonFullScreen)
        buttonFullScreen.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(buttonWH)
            make.right.equalTo(self.snp.right).offset(-20)
        }

        // 底部的line 总的line
        viewLine = UIView.init()
        viewLine.backgroundColor = UIColor.white
        self.addSubview(viewLine)
        viewLine.snp.makeConstraints { make in
            make.left.equalTo(buttonPlay.snp.right).offset(20)
            make.right.equalTo(buttonFullScreen.snp.left).offset(-20)
            make.height.equalTo(1)
            make.top.equalTo(15)
        }

        // 加载的 seek到的 进度
        viewLoadedLine = UIView.init()
        viewLoadedLine.backgroundColor = UIColor.blue
        self.addSubview(viewLoadedLine)
        viewLoadedLine.snp.makeConstraints { make in
            make.left.equalTo(viewLine.snp.left)
            make.height.equalTo(2)
            make.width.equalTo(0)
            make.centerY.equalTo(viewLine.snp.centerY)
        }

        // 播放当前 的时间 进度
        viewCurrentLine = UIView.init()
        viewCurrentLine.backgroundColor = UIColor.red
        self.addSubview(viewCurrentLine)
        viewCurrentLine.snp.makeConstraints { make in
            make.left.equalTo(viewLine.snp.left)
            make.height.equalTo(3)
            make.width.equalTo(0)
            make.centerY.equalTo(viewLine.snp.centerY)
        }

        // 当前时间
        labelCurrentTime = setupLabel()
        labelCurrentTime.text = "00:00"
        labelCurrentTime.snp.makeConstraints { make in
            make.left.equalTo(viewLine.snp.left)
            make.top.equalTo(viewLine.snp.bottom).offset(4)
        }

        // 总的时间
        labelTotalTime = setupLabel()
        labelTotalTime.text = "/ 00:00"
        labelTotalTime.snp.makeConstraints { make in
            make.left.equalTo(labelCurrentTime.snp.right).offset(3)
            make.top.equalTo(labelCurrentTime.snp.top)
        }
        
        let panView = UIView()
        panView.backgroundColor = UIColor.clear
        addSubview(panView)
        panView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(viewLine.snp.left)
            make.right.equalTo(viewLine.snp.right)
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesturePaned(pan:)))
        self.addGestureRecognizer(panGesture)
    }
    @objc private func panGesturePaned(pan: UIPanGestureRecognizer) {
        if beganPanBlock != nil {
            beganPanBlock!(pan)
        }
    }
    private func setupLabel() -> UILabel {

        let label = UILabel.init()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        addSubview(label)
        return label
    }

    func clickPlayButton(button _: UIButton) {

        if self.playOrPauseBlock != nil {
            self.playOrPauseBlock!(!self.nowIsPlaying)
        }
    }

    func clickFullButton(button _: UIButton) {

        if nowIsFull == true {
            nowIsFull = false
            buttonFullScreen.setImage(UIImage.init(named: "nowSmallScreen"), for: .normal)
        } else {
            nowIsFull = true
            buttonFullScreen.setImage(UIImage.init(named: "nowFullScreen"), for: .normal)
        }
        if self.fullOrSmallBlock != nil {
            self.fullOrSmallBlock!(nowIsFull)
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
