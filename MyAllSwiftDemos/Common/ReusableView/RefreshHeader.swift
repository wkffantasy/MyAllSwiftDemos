//
//  RefreshHeader.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/4/10.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

private var headerKey: Void?

extension UIScrollView {

    weak var header: RefreshHeader? {
        set {
            objc_setAssociatedObject(self, &headerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &headerKey) as! RefreshHeader?
        }
    }

    func addHeaderRefreshing(refreshingBlock: @escaping NoParamBlock) {

        header = RefreshHeader(frame: CGRect(x: 0, y: -60, width: frame.width, height: 60))
        header?.scrollView = self
        header?.setRefreshingBlock(refreshingParam: refreshingBlock)
    }
}

class RefreshHeader: UIView {

    private var refreshingBlock: NoParamBlock?
    private var tipLabel: UILabel!
    private let refreshingHeight: CGFloat = 60

    private var state: RefreshState = .notStart {
        didSet {
            if state != oldValue {
                refreshStateChanged()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("RefreshHeader will deinit")
    }

    func setup() {
        tipLabel = UILabel()
        tipLabel.text = "下载刷新"
        addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }

    weak var scrollView: UIScrollView? {
        didSet {
            scrollView?.addSubview(self)
        }
    }

    func refreshStateChanged() {

        if state == .refreshing {
            if self.refreshingBlock != nil {
                self.refreshingBlock!()
            }
            tipLabel.text = "正在刷新"
            UIView.animate(withDuration: 0.3, animations: {

                self.scrollView?.contentInset.top = self.refreshingHeight
            })
        }
    }

    func setRefreshingBlock(refreshingParam: @escaping NoParamBlock) {
        refreshingBlock = refreshingParam
    }

    public func endRefresh(infoParam: String?) {
        state = .refreshed
        if infoParam != nil {
            self.tipLabel.text = infoParam
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {

            UIView.animate(withDuration: 0.4, animations: {

                self.scrollView?.contentInset.top = 0

            }) { _ in

                self.state = .notStart
            }
        }
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview is UIScrollView {
            addObserver()
        }
    }

    private func addObserver() {
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        scrollView?.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }

    private func removeObserver() {
        scrollView?.removeObserver(self, forKeyPath: "contentSize")
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == "contentSize" {
            print("contentSize")
        } else if keyPath == "contentOffset" {
            let offsetY = scrollView?.contentOffset.y
            if (scrollView?.isDragging)! {
                //                if 0 >= refreshingHeight + offsetY! - 15 {
                //                    if state != .refreshing {
                //                        state = .refreshing
                //                    }
                //                } else {
                //                    state = .pulling

                //                }
            } else {
                if 0 >= refreshingHeight + offsetY! {
                    if state != .refreshing {
                        state = .refreshing
                    }
                } else {
                    state = .pulling
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
