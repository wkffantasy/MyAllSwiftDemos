//
//  Constants.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/7.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

import SnapKit

// all notification names
let touchNameOf3D = "touchNameOf3D"

// constants

/// player pan gestrue direction
enum PanDirection: Int {
    case panHorizontal = 0
    case panVertical = 1
}

/// player pan volume or brightness
enum PanVolumeOrBrightness: Int {
    case panVolume = 0
    case panBrightness = 1
}

let curveMaxHeight: CGFloat = 60

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

// download state
public enum DownloadState: Int {

    case Downloading

    case Pause

    case NotBegan

    case Compeleted

    case Failed
}

// refresh state
enum RefreshState: Int {
    case notStart // 静止状态
    case pulling // 拉动还没刷新的状态
    case refreshing // 刷新的状态
    case refreshed // 刷新完成的状态
}

// All Blocks in here
typealias NoParamBlock = () -> Void
typealias IntParamBlock = (Int) -> Void
typealias FloatParamBlock = (Float) -> Void
typealias CGFloatParamBlock = (CGFloat) -> Void
typealias BoolParamBlock = (Bool) -> Void
typealias ErrorParamBlock = (Error) -> Void
typealias StringParamBlock = (String) -> Void
