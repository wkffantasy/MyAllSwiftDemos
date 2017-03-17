//
//  WaveView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/17.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class WaveView: UIView {
    
    let waterWaveWidth:CGFloat = ScreenWidth
    let waterWaveHeight:CGFloat = 200
//    let waveColor = UIColor.colorWithRGBH(red: <#T##Int#>, green: <#T##Int#>, blue: <#T##Int#>, Alpha: <#T##Int#>);
//    let waveSpeed = 0.25/M_PI;
//    let waveSpeed2 = 0.3/M_PI;
//    let waveOffsetX = 0;
//    let wavePointY = _waterWaveHeight - 50;
//    let waveAmplitude = 13;
//    let waveCycle =  1.29 * M_PI / _waterWaveWidth;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
