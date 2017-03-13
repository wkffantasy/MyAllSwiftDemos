//
//  ViewController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var homeDataArray: Array<HomeModel>! = []
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyAllSwiftDemos"

        thisDataSource()
        setupUI()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.homeDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: HomeCell = HomeCell.cellWithTableView(tableView: tableView)
        cell.assignItData(model: self.homeDataArray[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {

        let thisModel: HomeModel = self.homeDataArray[indexPath.row]
        let selector = Selector.init(thisModel.jumpTo)
        self.perform(selector)
    }

    func jumpToMarqueeVC() {
        self.navigationController?.pushViewController(MarqueeController(), animated: true)
    }

    func setupUI() {

        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(0)
        }
    }

    func thisDataSource() {

        let homeDictArray = [
            [
                "title": "Label的跑马灯",
                "titleDescription": "当文字超过一定的长度的时候，该文字会一直轮播下去，也就是跑马灯的效果",
                "status": "待做",
                "jumpTo": "jumpToMarqueeVC",
            ],
        ]

        for item in homeDictArray {

            let model = HomeModel()
            model.title = item["title"]
            model.titleDescription = item["titleDescription"]
            model.status = item["status"]
            model.jumpTo = item["jumpTo"]
            homeDataArray.append(model)
        }
    }
}
