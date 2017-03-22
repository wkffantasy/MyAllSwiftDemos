//
//  CircleView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/22.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    private var totalCount :Int!
    init(frame: CGRect,totalCount:Int) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width/2
        assert(totalCount > 1 ,"")
        backgroundColor = UIColor.white
        self.totalCount = totalCount
    }
    override func draw(_ rect: CGRect) {
        
        let radius = self.frame.size.width / 2
        
        let marginAngle:CGFloat = CGFloat(M_PI) * 2 / CGFloat(totalCount)
        let halfMarginAngle = marginAngle / 2
        
        let SinX = radius*sin(halfMarginAngle)
        let CosY = radius*cos(halfMarginAngle)
        let beganPoint = CGPoint(x:radius-SinX,y:radius+CosY)
        let endPoint = CGPoint(x:radius-SinX/2,y:radius+CosY/2)
        
        assert(totalCount>1,"")
        for index in 0..<totalCount {

            var SinX = radius*sin(halfMarginAngle+CGFloat(index)*marginAngle)
            var CosY = radius*cos(halfMarginAngle+CGFloat(index)*marginAngle)
            SinX = CGFloat(fabsf(Float(SinX)))
            CosY = CGFloat(fabsf(Float(CosY)))
            var beganX:CGFloat
            var beganY:CGFloat
            var endX:CGFloat
            var endY:CGFloat
            let quadrant = getQuadrant(index: index)
            print("quadrant ==",quadrant,"index ==",index)
            if quadrant == 2 || quadrant==3 {
                beganX = radius - SinX
                endX = radius - SinX/3
            } else {
                beganX = radius + SinX
                endX = radius + SinX/3
            }
            if quadrant == 3 || quadrant==4 {
                beganY = radius + CosY
                endY = radius + CosY/3
            } else {
                beganY = radius - CosY
                endY = radius - CosY/3
            }
            let beganPoint = CGPoint(x:beganX,y:beganY)
            let endPoint = CGPoint(x:endX,y:endY)
            let path = UIBezierPath()
            UIColor.colorWithRGB(red: 52, green: 146, blue: 244).setStroke()
            path.move(to: beganPoint)
            path.addLine(to:endPoint)
            path.lineWidth = 2.0
            path.stroke()
            
        }

    }
    private func getQuadrant(index:Int)->Int{
        
        if index < totalCount / 2 {// 2  3
            return index<totalCount / 4 ? 3 : 2
        } else {// 1 4
            return index<(totalCount-totalCount / 4) ? 1 : 4
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
