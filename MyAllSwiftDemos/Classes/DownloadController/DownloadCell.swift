//
//  DownloadCell.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/27.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DownloadCell: UITableViewCell {

    typealias ShouldReloadThisRow = (DownloadCell) -> Void

    public var reloadRow: ShouldReloadThisRow?

    //    var downloadState = DownloadState.NotBegan

    var model: DownloadModel?
    let downloadTool = DownloadToolManage()
    var labelProgress: UILabel!
    var labelSpeed: UILabel!
    var labelRemainTime: UILabel!
    let buttonW = 100
    let buttonH = 18

    class func creatCellWithTableView(tableView: UITableView) -> DownloadCell {

        let cellId = "UITableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = DownloadCell.init(style: .default, reuseIdentifier: cellId)
        }
        return cell as! DownloadCell
    }

    public func assignItData(model: DownloadModel) {
        print("url ==", model.url)
        self.model = model
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        setupView()
    }

    func setupView() {

        labelProgress = setupLabel()
        labelProgress.text = "进度:"
        labelProgress.snp.makeConstraints { make in
            make.top.left.equalTo(10)
        }

        labelSpeed = setupLabel()
        labelSpeed.text = "速度:"
        labelSpeed.snp.makeConstraints { make in
            make.top.equalTo(labelProgress.snp.bottom).offset(10)
            make.left.equalTo(10)
        }

        labelRemainTime = setupLabel()
        labelRemainTime.text = "剩余时间:"
        labelRemainTime.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(labelSpeed.snp.bottom).offset(10)
        }

        let startDownloadButton = UIButton(type: .custom)
        startDownloadButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: .normal)
        startDownloadButton.setTitle("开始下载", for: .normal)
        startDownloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        startDownloadButton.addTarget(self, action: #selector(clickToDownload), for: .touchUpInside)
        startDownloadButton.backgroundColor = .green
        addSubview(startDownloadButton)
        startDownloadButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.width.equalTo(buttonW)
            make.height.equalTo(buttonH)
        }

        let pauseButton = UIButton(type: .custom)
        pauseButton.backgroundColor = .green
        pauseButton.setTitle("暂停", for: .normal)
        pauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        pauseButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
        pauseButton.addTarget(self, action: #selector(clickToPause(button:)), for: UIControlEvents.touchUpInside)
        addSubview(pauseButton)
        pauseButton.snp.makeConstraints { make in
            make.top.equalTo(startDownloadButton.snp.bottom).offset(10)
            make.right.equalTo(-10)
            make.width.equalTo(buttonW)
            make.height.equalTo(buttonH)
        }

        let goonButton = UIButton(type: .custom)
        goonButton.backgroundColor = .green
        goonButton.setTitle("继续下载", for: .normal)
        goonButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        goonButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
        goonButton.addTarget(self, action: #selector(clickToGoon(button:)), for: UIControlEvents.touchUpInside)
        addSubview(goonButton)
        goonButton.snp.makeConstraints { make in
            make.top.equalTo(pauseButton.snp.bottom).offset(10)
            make.right.equalTo(-10)
            make.width.equalTo(buttonW)
            make.height.equalTo(buttonH)
        }

        let sepLine = UIView()
        sepLine.backgroundColor = .red
        addSubview(sepLine)
        sepLine.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.height.equalTo(1)
            make.right.equalTo(0)
            make.bottom.equalTo(self.snp.bottom)
        }
    }

    func clickToPause(button _: UIButton) {
        print("clickToPause")
        downloadTool.pauseDownload()
    }

    func clickToGoon(button _: UIButton) {
        print("clickToGoon")
        self.downloadTool.goonDownload()
    }

    @objc private func clickToDownload() {
        print("clickToDownload")
        let progressBlock = { [weak self] (progress: String, remainTime: String, speed: String) in
            self?.labelRemainTime.text = "剩余时间:" + remainTime
            self?.labelSpeed.text = "速度:" + speed
            self?.labelProgress.text = "进度:" + progress
        }
        let completeBlock = { (path: String) in
            print("completeBlock path ==\(path)")
        }
        let failedBlock = { (error: Error) in
            print("failedBlock error==", error)
        }

        let downloadUrl = PathAndVideoNameTool.tool.videoConverUrlToDownloadUrl(urlString: (model?.url)!)
        let filePath = PathAndVideoNameTool.tool.videoConverUrlToPath(urlString: (model?.url)!)
        print("downloadUrl ==", downloadUrl)
        print("filePath ==", filePath)
        downloadTool.downloadVideoFiles(downloadUrl: downloadUrl, toSavePath: filePath as String, progressBlock: progressBlock, completeBlock: completeBlock, failedBlock: failedBlock)
    }

    private func setupLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.colorWithHexString("333333")
        label.font = UIFont.systemFont(ofSize: 14)
        addSubview(label)
        return label
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("this cell will be deinit")
        downloadTool.deleteThisDownloadTool()
    }
}
