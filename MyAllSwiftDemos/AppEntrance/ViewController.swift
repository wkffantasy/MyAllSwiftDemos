//
//  ViewController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var functionViewsArray: Array<HomeModel>! = []
    var funnyViewsArray: Array<HomeModel>! = []
    let headerDataArray = [
        "some views that can be directly use",
        "something fun,it looks like more friendly to users",
    ]
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyAllSwiftDemos"
        thisDataSource()
        setupUI()
    }

    func numberOfSections(in _: UITableView) -> Int {
        return headerDataArray.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.functionViewsArray.count
        } else {
            return self.funnyViewsArray.count
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeHeader.headerWithTableView(tableView: tableView)
        header.updateContent(text: self.headerDataArray[section])
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell: HomeCell = HomeCell.cellWithTableView(tableView: tableView)
            cell.assignItData(model: self.functionViewsArray[indexPath.row])
            return cell
        } else {
            let cell: HomeCell = HomeCell.cellWithTableView(tableView: tableView)
            cell.assignItData(model: self.funnyViewsArray[indexPath.row])
            return cell
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {

        var thisModel: HomeModel
        if indexPath.section == 0 {
            thisModel = self.functionViewsArray[indexPath.row]
        } else {

            thisModel = self.funnyViewsArray[indexPath.row]
        }
        let selector = Selector.init(thisModel.jumpTo)
        self.perform(selector)
    }

    func jumpToMarqueeVC() {
        self.navigationController?.pushViewController(MarqueeController(), animated: true)
    }

    func jumpToCurveVC() {
        self.navigationController?.pushViewController(CurveController(), animated: true)
    }

    func jumpToTabSelectVC() {
        //        let tabsVC = TabsSelectController.init(isTitle: true)
        let tabsVC = TabsSelectController.init(isTitle: false)
        self.navigationController?.pushViewController(tabsVC, animated: true)
    }

    func jumpToVideoVC() {
        self.navigationController?.pushViewController(DemoVideoController(), animated: true)
    }
    func jumpToWaveVC() {
        self.navigationController?.pushViewController(WaveController(), animated: true)
    }

    func jumpToNoMarginScrollVC() {
        self.navigationController?.pushViewController(NoMarginScrollController(), animated: true)
    }
    func jumpToNoDialVC() {
        self.navigationController?.pushViewController(DialController(), animated: true)
    }

    func setupUI() {

        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 60
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(0)
        }
    }

    func thisDataSource() {

        for item in functionsArray {
            let model = HomeModel()
            model.title = item["title"]
            model.titleDescription = item["titleDescription"]
            model.status = item["status"]
            model.jumpTo = item["jumpTo"]
            functionViewsArray.append(model)
        }

        for item in funnyArray {
            let model = HomeModel()
            model.title = item["title"]
            model.titleDescription = item["titleDescription"]
            model.status = item["status"]
            model.jumpTo = item["jumpTo"]
            funnyViewsArray.append(model)
        }
    }
}
