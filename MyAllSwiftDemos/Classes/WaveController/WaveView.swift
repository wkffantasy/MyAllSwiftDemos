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

    let waveSpeed: CGFloat = CGFloat(0.25 / M_PI)
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

        //        secondLayer = CAShapeLayer()
        //        secondLayer.fillColor = waveColor.cgColor
        //        self.layer.addSublayer(secondLayer)
        //
        //        thirdLayer = CAShapeLayer()
        //        thirdLayer.fillColor = waveColor.cgColor
        //        self.layer.addSublayer(thirdLayer)

        displayLink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        displayLink.add(to: .main, forMode: .commonModes)
    }

    func getCurrentWave() {

        waveOffsetX += waveSpeed
        setFirstPath()
    }

    func setFirstPath() {

        //        let waveCycle:CGFloat =  CGFloat(1.29 * M_PI) / waterWaveWidth;
        //        let path = CGMutablePath()
        //        var y:CGFloat = waterWaveHeight - 50
        //        path.move(to: CGPoint(x:0,y:y))

        //        for var x:CGFloat = 0; x <= waterWaveHeight;x += 1{
        //            y = waveAmplitude * sin(waveCycle * x + waveOffsetX - 10) + y + 10
        //
        //        }
    }
}
