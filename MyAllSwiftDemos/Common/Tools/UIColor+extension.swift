//
//  UIColor+extension.swift
//  BaseProjectSwift3.0
//
//  Created by 雅昌－一粒 on 16/10/12.
//  Copyright © 2016年 artron. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     *  设置随机颜色
     *
     *  @return 随机颜色
     */
    static func randomColor() -> UIColor {

        let hue: CGFloat = (CGFloat(arc4random() % 256) / 256.0) //  0.0 to 1.0
        let saturation: CGFloat = (CGFloat(arc4random() % 128) / 256.0) + 0.5 //  0.5 to 1.0, away from white
        let brightness: CGFloat = (CGFloat(arc4random() % 128) / 256.0) + 0.5 //  0.5 to 1.0, away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

    /**
     *  color 转 image
     *
     *  @param color
     *
     *  @return image
     */
    class func createImageWithColor(_ color: UIColor) -> UIImage {

        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let theImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return theImage
    }

    /**
     *  设置颜色---带透明值的
     *
     *  @param HexColor 颜色代码
     *
     *  @return 返回颜色
     */
    class func colorWithHexString(_ stringToConvert: String, Alpha: CGFloat = 1) -> UIColor {
        var cString = stringToConvert.trimmingCharacters(in: CharacterSet.whitespaces).uppercased()

        if cString.hasPrefix("#") {
            cString = cString.SubStringFrom(from: 1)
        }
        let stringlen = cString.length
        if stringlen != 6 {
            return UIColor.white
        }

        let rString = cString.subString(start: 0, end: 2)
        let gString = cString.subString(start: 2, end: 4)
        let bString = cString.subString(start: 4, end: 6)

        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: Alpha)
    }

    class func colorWithRGBH(red: Int, green: Int, blue: Int, Alpha: Int = 1) -> UIColor {

        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(Alpha))
    }

    class func colorWithRGB(red: Int, green: Int, blue: Int) -> UIColor {

        return colorWithRGBH(red: red, green: green, blue: blue, Alpha: 1)
    }
}
