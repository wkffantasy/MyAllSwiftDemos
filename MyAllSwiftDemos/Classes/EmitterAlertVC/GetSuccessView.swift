//
//  GetSuccessView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/16.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class GetSuccessView: NSObject {

    public func show() {

        let window = UIApplication.shared.keyWindow

        let backgroundView = UIView(frame: (window?.bounds)!)
        backgroundView.backgroundColor = UIColor.colorWithRGBH(red: 0, green: 0, blue: 0, Alpha: 0.8)
        window?.addSubview(backgroundView)

        // about success view
        let successView = SuccessView()
        backgroundView.addSubview(successView)
        successView.snp.makeConstraints { make in
            make.center.equalTo(backgroundView.snp.center)
            make.left.equalTo(80)
            make.right.equalTo(-80)
        }

        successView.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        successView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            successView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            successView.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            UIView.animate(withDuration: 0.4, animations: {
                successView.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
                successView.alpha = 0.5
            }, completion: { _ in
                backgroundView.removeFromSuperview()
            })
        }

        // emitter
        let emitter = addEmitterLayer()
        startAnimate(emitterLayer: emitter)
        backgroundView.layer.addSublayer(emitter)
    }

    private func addEmitterLayer() -> CAEmitterLayer {

        let window = UIApplication.shared.keyWindow

        let cell1 = createCell(image: creactImage(color: UIColor.red))
        cell1.name = "red"

        let cell2 = createCell(image: creactImage(color: UIColor.yellow))
        cell2.name = "yellow"

        let cell3 = createCell(image: creactImage(color: UIColor.blue))
        cell3.name = "blue"

        let cell4 = createCell(image: UIImage.init(named: "success_star")!)
        cell4.name = "star"

        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = window!.center
        emitterLayer.emitterSize = window!.bounds.size
        emitterLayer.emitterMode = CAEmitterLayerEmitterMode.outline
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.rectangle
        emitterLayer.renderMode = CAEmitterLayerRenderMode.oldestFirst
        emitterLayer.emitterCells = [cell1, cell2, cell3, cell4]
        return emitterLayer
    }

    private func createCell(image: UIImage) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.name = "heart"
        cell.contents = image.cgImage

        cell.scale = 0.6
        cell.scaleRange = 0.6
        cell.lifetime = 5
        cell.birthRate = 40

        cell.velocity = 200
        cell.velocityRange = 200
        cell.yAcceleration = 9.8
        cell.xAcceleration = 0

        cell.emissionRange = CGFloat(M_PI)
        cell.scaleSpeed = -0.05
        cell.spin = 2 * CGFloat(M_PI)
        cell.spinRange = 2 * CGFloat(M_PI)

        return cell
    }

    private func creactImage(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 13, height: 17)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    private func startAnimate(emitterLayer: CAEmitterLayer) {

        let redBurst = CABasicAnimation.init(keyPath: "emitterCells.red.birthRate")
        redBurst.fromValue = 30
        redBurst.toValue = 0
        redBurst.duration = 0.5
        redBurst.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)

        let yellowBurst = CABasicAnimation.init(keyPath: "emitterCells.yellow.birthRate")
        yellowBurst.fromValue = 30
        yellowBurst.toValue = 0
        yellowBurst.duration = 0.5
        yellowBurst.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)

        let blueBurst = CABasicAnimation.init(keyPath: "emitterCells.blue.birthRate")
        blueBurst.fromValue = 30
        blueBurst.toValue = 0
        blueBurst.duration = 0.5
        blueBurst.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)

        let starBurst = CABasicAnimation.init(keyPath: "emitterCells.star.birthRate")
        starBurst.fromValue = 30
        starBurst.toValue = 0
        starBurst.duration = 0.5
        starBurst.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)

        let group = CAAnimationGroup()
        group.animations = [redBurst, yellowBurst, blueBurst, starBurst]
        emitterLayer.add(group, forKey: "heartsBurst")
    }
}
