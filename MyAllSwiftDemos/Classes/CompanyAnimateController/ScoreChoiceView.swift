//
//  ScoreChoiceView.swift
//  toeflios
//
//  Created by fantasy on 17/5/31.
//  Copyright © 2017年 Facebook. All rights reserved.
//

import UIKit

class ScoreChoiceView: UIView {

    typealias CallBackBlock = (String, Int) -> Void

    public var callBack: CallBackBlock?

    let buttonH: CGFloat = 44
    private var scoresArray: Array<String>!

    init(frame: CGRect,
         dataArray: Array<String>,
         callBack: @escaping CallBackBlock) {
        super.init(frame: frame)
        assert(dataArray.count > 0, "")
        self.scoresArray = dataArray
        self.callBack = callBack
        addAllButtons()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addAllButtons() {

        var lastButton: LearnIntentionButton?
        for i in 0 ..< scoresArray.count {
            let button = LearnIntentionButton.init(frame: .zero, buttonH: buttonH, title: scoresArray[i], selectColor: UIColor.colorWithHexString("5798ef"), callBack: { [weak self] title, _ in

                print("in score choive view title ==", title)
                if self?.callBack != nil {
                    self?.callBack!(title, i)
                }
            })
            addSubview(button)
            button.tag = i
            button.snp.makeConstraints({ make in
                if i == 0 {
                    make.top.equalTo(0)
                } else {
                    make.top.equalTo((lastButton?.snp.bottom)!).offset(20)
                }
                make.left.equalTo(60)
                make.right.equalTo(self.snp.right).offset(-60)
                make.height.equalTo(buttonH)
            })
            lastButton = button
        }
        lastButton?.snp.makeConstraints({ make in
            make.bottom.equalTo(self.snp.bottom)
        })
    }
}
