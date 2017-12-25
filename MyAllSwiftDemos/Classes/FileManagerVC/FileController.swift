//
//  FileController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/11.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class FileController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataArray: Array<String>!
    var tableView: UITableView!
    let fileManager = FileManager.default

    let allPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        getLocalData()
        setupView()
    }

    func setupView() {
        tableView = UITableView.init()
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(0)
        }
    }

    func getLocalData() {

        var files = [String]()

        let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: allPath as String)!
        while let element = enumerator.nextObject() as? String {
            files.append(element)
        }
        print("allPath ==", allPath)
        print("files ==", files)

        dataArray = files
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("click to delete")
        if editingStyle == .delete {

            let path = (allPath as String) + "/" + dataArray[indexPath.row]
            if fileManager.fileExists(atPath: path) {
                do {
                    try fileManager.removeItem(atPath: path)
                } catch {
//                    log.error("failed : \(error.localizedDescription)")
                }
            }

            dataArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: FileVideoCell = FileVideoCell.cellWithTableView(tableView: tableView)
        cell.assignItData(title: dataArray[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {

        let title = dataArray[indexPath.row]
        let path = (allPath as String) + "/" + title
        print("title ==", title)
        print("path ==", path)
        print("allPath ==", allPath)
        self.navigationController?.pushViewController(PlayLocalVideoController.init(localUrl: path, name: title), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
