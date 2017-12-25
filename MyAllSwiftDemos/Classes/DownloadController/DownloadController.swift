//
//  DownloadController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/27.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DownloadController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var dataArray: Array<DownloadModel> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDataArray()
        setupView()

        // 打开数据库
        DownloadFMDBManger.tool.openDatabase(successBlock: { _ in
            print("open fmdb success")
        }) { _ in
            print("open fmdb failed")
        }
    }

    func setupDataArray() {

        let urlArray = [
            "http://v.smartstudy.com/pd/videos/2015/67/df/10422/mp4/dest.m3u8",
            "http://media7.smartstudy.com/pd/videos/2015/3e/5a/16041/mp4/dest.m3u8",
            "http://http://media7.smartstudy.com/pd/videos/2015/af/c7/16040/mp4/dest.m3u8",
            "http://www.jxgbwlxy.gov.cn/tm/course/041629011/sco1/1.mp4",
        ]
        for url in urlArray {
            let model = DownloadModel()
            model.url = url
            dataArray.append(model)
        }
    }

    func setupView() {
        tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(0)
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DownloadCell.creatCellWithTableView(tableView: tableView)
        cell.assignItData(model: dataArray[indexPath.row])
        return cell
    }

    deinit {
        DownloadFMDBManger.tool.closeThis()
//        log.error("this download controller will be deinit")
    }
}
