//
//  LearnIntentionButton.swift
//  toeflios
//
//  Created by fantasy on 17/5/26.
//  Copyright © 2017年 Facebook. All rights reserved.
//

import UIKit

class LearnIntentionButton: UIButton {

    typealias CallBackBlock = (String, Int) -> Void

    public var callBack: CallBackBlock?

    private var selectColor: UIColor!
    private var title: String!

    init(frame: CGRect,
         buttonH: CGFloat,
         title: String,
         selectColor: UIColor?,
         callBack: @escaping CallBackBlock) {
        super.init(frame: frame)

        self.title = title
        self.selectColor = selectColor

        layer.masksToBounds = true
        layer.cornerRadius = buttonH / 2
        layer.borderColor = UIColor.colorWithHexString("eaeff2").cgColor
        layer.borderWidth = 1
        backgroundColor = UIColor.white

        setTitle(title, for: .normal)
        setTitleColor(UIColor.colorWithHexString("2e3236"), for: .normal)

        addTarget(self, action: #selector(clickThisButton(button:)), for: .touchUpInside)
        self.callBack = callBack
    }

    @objc func clickThisButton(button: UIButton) {

        print("click this Button title=", self.title, button.tag)

      if self.selectColor != nil {
        button.backgroundColor = selectColor
        layer.borderWidth = 0
        button.setTitleColor(UIColor.white, for: .normal)
        
      }

        if self.callBack != nil {
            self.callBack!(self.title, button.tag)
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
