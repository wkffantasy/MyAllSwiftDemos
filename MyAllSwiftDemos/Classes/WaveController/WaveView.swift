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
    let waveSpeed: CGFloat = CGFloat(0.05 / M_PI)

    var waveOffsetX: CGFloat = 0
    var waveAmplitude: CGFloat!

    var firstLayer: CAShapeLayer!
    var secondLayer: CAShapeLayer!
    var displayLink: CADisplayLink!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        //        self.backgroundColor = UIColor.colorWithRGB(red: 251, green: 91, blue: 91)
        self.backgroundColor = RGBColor(251, 91, 91)
        waveAmplitude = frame.height / 2
        startWave()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func removeThisDisplayLink() {
        displayLink.invalidate()
    }

    func startWave() {
        let waveColor = UIColor.colorWithHexString("ff8900")

        firstLayer = CAShapeLayer()
        firstLayer.fillColor = waveColor.cgColor
        self.layer.addSublayer(firstLayer)

        secondLayer = CAShapeLayer()
        secondLayer.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(secondLayer)

        displayLink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        displayLink.add(to: .main, forMode: .commonModes)
    }

    func getCurrentWave() {
        waveOffsetX += waveSpeed
        for index in 0 ... 1 {
            let waveCycle: CGFloat = CGFloat(1.1 * M_PI) / (waterWaveWidth / 3)
            let path = CGMutablePath()
            var waveY: CGFloat = 0
            path.move(to: CGPoint(x: 0, y: waveY))
            for x in 0 ... Int(waterWaveWidth) {
                waveY = waveAmplitude - waveAmplitude * sin((waveCycle * CGFloat(x) + CGFloat(index) * CGFloat(M_PI)) + waveOffsetX)
                path.addLine(to: CGPoint(x: CGFloat(x), y: waveY))
            }
            path.addLine(to: CGPoint(x: waterWaveWidth, y: self.frame.size.height))
            path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
            path.closeSubpath()
            if index == 0 {
                secondLayer.path = path
            } else {
                firstLayer.path = path
            }
        }
    }

    deinit {
        print("this wave will be deinit")
    }
}
