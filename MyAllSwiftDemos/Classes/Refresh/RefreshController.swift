//
//  RefreshController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/4/10.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class RefreshController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var dataSource: Array<Int>!
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupUI()
    }

    func setupUI() {
        dataSource = []
        for index in 0 ..< 4 {
            dataSource.append(index)
        }

        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        view.addSubview(tableView)

        tableView.addHeaderRefreshing {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5, execute: {
                self.tableView.header?.endRefresh(infoParam: "刷新成功")
            })
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        cell!.textLabel?.text = "第\(indexPath.row)个"
        return cell!
    }
}
