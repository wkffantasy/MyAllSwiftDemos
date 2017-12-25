//
//  NoMarginRollingView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class NoMarginRollingView: UIView, UIScrollViewDelegate {

    typealias ClickButtonBlock = (Int) -> Void
    typealias ScrollCurrentIndexBlock = (Int) -> Void

    public var clickButtonBlock: ClickButtonBlock?
    public var currentIndexBlock: ScrollCurrentIndexBlock?

    private var imagesArray: Array<String>! = []
    private var scrollTime: CGFloat = 3
    private var scrollView: UIScrollView!
    private var timer: Timer?
    private var currentPage: Int!

    init(frame: CGRect, imageArray: Array<String>, time: CGFloat) {
        super.init(frame: frame)

        assert(imageArray.count > 0, "this array should not be 0")
        self.scrollTime = time == 0 ? self.scrollTime : time

        initThisImageArray(imageArray: imageArray)
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }

    private func setupViews() {

        assert(self.imagesArray.count != 2, "")
        assert(self.imagesArray.count != 3, "")

        scrollView = UIScrollView.init()
        scrollView.frame = self.bounds
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.red
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.frame.size.width * CGFloat(self.imagesArray.count), height: 0)
        self.addSubview(scrollView)

        var tag: CGFloat = 0
        for imageName in self.imagesArray {

            let imageView = UIImageView.init()
            imageView.image = UIImage.init(named: imageName)
            imageView.isUserInteractionEnabled = true
            imageView.tag = Int(tag) + 100
            imageView.frame = CGRect(x: tag * self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            scrollView.addSubview(imageView)
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickImage(tap:)))
            imageView.addGestureRecognizer(tap)

            tag = tag + 1.0
        }

        if self.imagesArray.count != 1 {
            self.scrollView.setContentOffset(CGPoint(x: self.frame.size.width, y: 0), animated: true)
            addTimer()
        }
        self.currentPage = 0
    }

    func scrollViewWillBeginDragging(_: UIScrollView) {
        removeTimer()
    }

    func scrollViewDidEndDragging(_: UIScrollView, willDecelerate _: Bool) {
        addTimer()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        let thisWidth = self.frame.size.width

        self.currentPage = Int(point.x / thisWidth - 1)
        if point.x == 0 {

            self.scrollView.setContentOffset(CGPoint(x: thisWidth * CGFloat(self.imagesArray.count - 2), y: 0), animated: false)

        } else if point.x == thisWidth * CGFloat(self.imagesArray.count - 1) {

            self.scrollView.setContentOffset(CGPoint(x: thisWidth, y: 0), animated: false)
        }
        if self.currentIndexBlock != nil {
            self.currentIndexBlock!(self.currentPage)
        }
    }

    @objc private func clickImage(tap: UITapGestureRecognizer) {
        let imageView = tap.view
        if self.clickButtonBlock != nil {
            self.clickButtonBlock!(Int((imageView?.tag)! - 100 - 1))
        }
    }

    private func addTimer() {

        self.timer = Timer.init(timeInterval: TimeInterval(self.scrollTime), target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: .commonModes)
    }

    @objc private func runTimer() {

//        log.debug("runTimer")
        let thisWidth = self.frame.size.width
        var x: CGFloat = 0
        if self.currentPage == self.imagesArray.count - 3 {
            x = thisWidth * CGFloat((self.imagesArray.count - 1))
        } else {
            x = thisWidth * CGFloat(self.currentPage + 2)
        }
        self.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }

    private func initThisImageArray(imageArray: Array<String>) {

        if imageArray.count == 1 {
            self.imagesArray = imageArray
            return
        }

        let lastImage = imageArray.last
        self.imagesArray.append(lastImage!)
        for imageName in imageArray {
            self.imagesArray.append(imageName)
        }

        let firstImage = imageArray.first
        self.imagesArray.append(firstImage!)
        assert(self.imagesArray.count == imageArray.count + 2, "")
    }

    deinit {
        removeTimer()
    }
}
