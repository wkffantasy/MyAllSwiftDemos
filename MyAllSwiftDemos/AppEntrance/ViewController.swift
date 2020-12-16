//
//  ViewController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var paramArray: Array<Dictionary<String, String>> = []
    private var index: Int = 0

    private var dataArray: Array<HomeModel>! = []

    let headerDataArray = [
        "some views that can be directly used",
        "something fun,it looks like more friendly to users",
        "something that not directly obvious",
    ]
    var tableView: UITableView!

    init(index: Int, paramArray: Array<Dictionary<String, String>>) {
        self.paramArray = paramArray
        self.index = index
        super.init(nibName: nil, bundle: nil)
        setTitle()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        thisDataSource()
        setupUI()
        addOberser()
        print("tabbar height ",tabBarController?.tabBar.frame)
        print("navi height",navigationController?.navigationBar.frame)
        print("screen.bounds",UIScreen.main.bounds)
        print("screen statusBar",UIApplication.shared.statusBarFrame)
        
    }

    func setTitle() {
        switch self.index {
        case 0:
            self.title = "Views"
        case 1:
            self.title = "Funny"
        case 2:
            self.title = "Others"
        default:
            self.title = "I donot know"
        }
    }

    func addOberser() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(noti:)), name: NSNotification.Name(rawValue: touchNameOf3D), object: nil)
    }

    @objc func receiveNotification(noti: Notification) {
        let userInfo = noti.userInfo
        let name = String(format: "%@", userInfo?["name"] as! CVarArg)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            if name.length > 0 {
                switch name {
                case "test1":
                    self.jumpToMarqueeVC()
                case "test2":
                    self.jumpToTabSelectVC()
                case "test3":
                    self.jumpToVideoVC()
                default:break
                }
            }
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeHeader.headerWithTableView(tableView: tableView)
        header.updateContent(text: headerDataArray[self.index])
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: HomeCell = HomeCell.cellWithTableView(tableView: tableView)
        cell.assignItData(model: dataArray[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {

        let thisModel = dataArray[indexPath.row]
        let selector: Selector! = Selector.init(thisModel.jumpTo)
        self.perform(selector)
    }

    @objc func jumpToMarqueeVC() {
        self.navigationController?.pushViewController(MarqueeController(), animated: true)
    }

    @objc func jumpToCurveVC() {
        self.navigationController?.pushViewController(CurveController(), animated: true)
    }

    @objc func jumpToRefreshVC() {
        self.navigationController?.pushViewController(RefreshController(), animated: true)
    }

    @objc func jumpToScrollManyTableViewVC() {
        self.navigationController?.pushViewController(ScrollManyTabsViewController(), animated: true)
    }

    @objc func jumpToPlayTextVC() {
        self.navigationController?.pushViewController(PlayTextController(), animated: true)
    }

    @objc func jumpToFMDB() {
        self.navigationController?.pushViewController(FMDBontroller(), animated: true)
    }

    @objc func jumpToTabSelectVC() {
        //        let tabsVC = TabsSelectController.init(isTitle: true)
        let tabsVC = TabsSelectController.init(isTitle: false)
        self.navigationController?.pushViewController(tabsVC, animated: true)
    }

    @objc func jumpToVideoVC() {
        self.navigationController?.pushViewController(DemoVideoController(), animated: true)
    }

    @objc func jumpToWaveVC() {
        self.navigationController?.pushViewController(WaveController(), animated: true)
    }

    @objc func jumpToNoMarginScrollVC() {
        self.navigationController?.pushViewController(NoMarginScrollController(), animated: true)
    }

    @objc func jumpToNoDialVC() {
        self.navigationController?.pushViewController(DialController(), animated: true)
    }

    @objc func jumpToNoDownloadVC() {
        self.navigationController?.pushViewController(DownloadController(), animated: true)
    }

    @objc func jumpToEmitterAlertVC() {
        self.navigationController?.pushViewController(EmitterAlertController(), animated: true)
    }

    @objc func jumpToFileItunesVC() {
        self.navigationController?.pushViewController(FileController(), animated: true)
    }

    @objc func jumpToRealmVC() {
        self.navigationController?.pushViewController(RealmController(), animated: true)
    }
    @objc func jumpToAnimateInRN() {
        self.navigationController?.pushViewController(CompanyAnimateController(), animated: true)
    }
    @objc func jumpToCloudAnimateVC() {
        self.navigationController?.pushViewController(CloudController(), animated: true)
    }

    func setupUI() {

        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 60
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(0)
        }
    }

    func thisDataSource() {

        for item in paramArray {
            let model = HomeModel()
            model.title = item["title"]
            model.titleDescription = item["titleDescription"]
            model.status = item["status"]
            model.jumpTo = item["jumpTo"]
            dataArray.append(model)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
