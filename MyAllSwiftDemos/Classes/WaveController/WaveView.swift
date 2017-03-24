//
//  WaveView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/17.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class WaveView: UIView {

    let waterWaveWidth: CGFloat = ScreenWidth
    let waterWaveHeight: CGFloat = 200

    let waveSpeed: CGFloat = CGFloat(0.08 / M_PI)
    let waveSpeed2: CGFloat = CGFloat(0.3 / M_PI)
    var waveOffsetX: CGFloat = 0
    //    let wavePointY = waterWaveHeight - 50.0
    let waveAmplitude: CGFloat = 13

    var firstLayer: CAShapeLayer!
    var secondLayer: CAShapeLayer!
    var thirdLayer: CAShapeLayer!
    var displayLink: CADisplayLink!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorWithRGB(red: 251, green: 91, blue: 91)
        startWave()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startWave() {
        let waveColor = UIColor.colorWithRGBH(red: 251, green: 251, blue: 251, Alpha: 0.1)

        firstLayer = CAShapeLayer()
        firstLayer.fillColor = waveColor.cgColor
        self.layer.addSublayer(firstLayer)

        secondLayer = CAShapeLayer()
        secondLayer.fillColor = UIColor.colorWithRGBH(red: 233, green: 233, blue: 233, Alpha: 0.1).cgColor
        self.layer.addSublayer(secondLayer)

        displayLink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        displayLink.add(to: .main, forMode: .commonModes)
    }

    func getCurrentWave() {
        waveOffsetX += waveSpeed
        setFirstPath()
        setSecondPath()
    }

    func setSecondPath() {
        let waveCycle: CGFloat = CGFloat(1.1 * M_PI) / waterWaveWidth
        let path = CGMutablePath()
        var waveY: CGFloat = waterWaveHeight - 50
        path.move(to: CGPoint(x: 0, y: waveY))
        for x in 0 ... Int(waterWaveWidth) {
            waveY = (waveAmplitude - 2) * sin(waveCycle * CGFloat(x) + waveOffsetX) + 10 + waterWaveHeight - 50
            path.addLine(to: CGPoint(x: CGFloat(x), y: waveY))
        }
        path.addLine(to: CGPoint(x: waterWaveWidth, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        path.closeSubpath()
        secondLayer.path = path
    }

    func setFirstPath() {
        let waveCycle: CGFloat = CGFloat(1.1 * M_PI) / waterWaveWidth
        let path = CGMutablePath()
        var waveY: CGFloat = waterWaveHeight - 50
        path.move(to: CGPoint(x: 0, y: waveY))
        for x in 0 ... Int(waterWaveWidth) {
            waveY = waveAmplitude * sin(waveCycle * CGFloat(x) + waveOffsetX - 10) + 10 + waterWaveHeight - 50
            path.addLine(to: CGPoint(x: CGFloat(x), y: waveY))
        }
        path.addLine(to: CGPoint(x: waterWaveWidth, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        path.closeSubpath()
        firstLayer.path = path
    }
}
