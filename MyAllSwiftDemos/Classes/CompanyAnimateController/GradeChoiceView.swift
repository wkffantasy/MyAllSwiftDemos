//
//  GradeChoiceView.swift
//  toeflios
//
//  Created by fantasy on 17/5/26.
//  Copyright © 2017年 Facebook. All rights reserved.
//

import UIKit

class GradeChoiceView: UIView {

    typealias CallBackBlock = (String, Int) -> Void

    public var callBack: CallBackBlock?

    private var containView: UIView!

    let dataArray = [
        "初中",
        "高中",
        "大学",
        "毕业",
        "其他",
    ]
    let selectColorArray: Array<UIColor> = [
        UIColor.colorWithHexString("3fd0ad"),
        UIColor.colorWithHexString("fe6d4b"),
        UIColor.colorWithHexString("5798ef"),
        UIColor.colorWithHexString("9fd45d"),
        UIColor.colorWithHexString("ffcd41"),
    ]

    let buttonW: CGFloat = 120
    let buttonH: CGFloat = 44

    init(frame: CGRect,
         callBack: @escaping CallBackBlock) {
        super.init(frame: frame)
        self.callBack = callBack
        addAllButtons()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addAllButtons() {
        containView = UIView()
        addSubview(containView)
        containView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(0)
        }
        var lastButton: LearnIntentionButton?
        for i in 0 ..< dataArray.count {

            let button = LearnIntentionButton.init(frame: .zero, buttonH: buttonH, title: dataArray[i], selectColor: selectColorArray[i], callBack: { [weak self] title, tag in

                print("GradeChoiceView title ==", title, tag)
                if self?.callBack != nil {
                    self?.callBack!(title, tag)
                }

            })
            containView.addSubview(button)
            button.tag = i

            switch i {
            case 0:
                button.snp.makeConstraints({ make in
                    make.top.left.equalTo(0)
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                })
            case 1:
                button.snp.makeConstraints({ make in
                    make.right.top.equalTo(0)
                    make.left.equalTo((lastButton?.snp.right)!).offset(50)
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                })
            case 2:
                button.snp.makeConstraints({ make in
                    make.top.equalTo((lastButton?.snp.bottom)!).offset(25)
                    make.centerX.equalTo(containView.snp.centerX)
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                })
            case 3:
                button.snp.makeConstraints({ make in
                    make.bottom.left.equalTo(0)
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                    make.top.equalTo((lastButton?.snp.bottom)!).offset(25)
                })
            case 4:
                button.snp.makeConstraints({ make in
                    make.bottom.right.equalTo(0)
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                })

            default:
                button.snp.makeConstraints({ make in
                    make.top.left.equalTo(0)
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                })
            }

            lastButton = button
        }
    }
}
