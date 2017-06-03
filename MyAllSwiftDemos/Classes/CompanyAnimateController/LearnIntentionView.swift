//
//  LearnIntentionView.swift
//  toeflios
//
//  Created by fantasy on 17/5/24.
//  Copyright © 2017年 Facebook. All rights reserved.
//

import UIKit


class LearnIntentionView: UIView, UITextFieldDelegate {

    typealias CallBackBlock = (Dictionary<String, String>,LearnIntentionView) -> Void

    public var callBackToRN: CallBackBlock?

    private var headerView: UIView!
    private var functionView: UIView!
    private var titleView: TitleAndSubtileView!

    private var personHeader: UIImageView!
    private var personBody: UIImageView!

    private var gradeLeftImageView: UIImageView?
    private var gradeRightImageView: UIImageView?
    private var gradeBodyImageView: UIImageView?
    private var gradeHeaderImageView: UIImageView?
    private var timeCardView: UIImageView?
    private var scoreCardView: UIImageView?
    private var examCardView: UIImageView?
  //有没有考过托福
    private var scoreTextField: UITextField?
    private var haveButton:LearnIntentionButton?
    private var noButton:LearnIntentionButton?
  
    private let headerH: CGFloat = 270
    private let titleViewH: CGFloat = 110

    private let gradeAnimateTime = TimeInterval(1)

    private var coverButton: UIButton?
    private var tipLabel: UILabel?

    // 回调rn 四个参数
    private var callBackGrade: String?
    private var callBackTime: String?
    private var callBackScore: String?
    private var callBackExam: String?

    let scoresArray = [
        "80-89",
        "90-99",
        "100以上",
    ]

    let haveExamArray = [
        "考过",
        "还没有",
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)

        print("init LearnIntentionView")
        backgroundColor = UIColor.white

        setupHeaderView()
        setupTitleView()
        setupFuctionView()
        addObsverOfKeyBoard()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addObsverOfKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keybordDidHide(noti:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }

    func setupHeaderView() {
        headerView = UIView()
        headerView.clipsToBounds = true
        headerView.backgroundColor = RGBColor(248, 250, 255)
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: headerH)
        addSubview(headerView)

        // 添加云彩和圆圈的动画
        let cloudAndCirleView = CircleAndCloudAnimateView(frame: headerView.bounds)
        headerView.addSubview(cloudAndCirleView)

        // 添加人物的图片
        addNormalPerson()
    }

    func setupTitleView() {

        titleView = TitleAndSubtileView(frame: CGRect(x: 0, y: headerH, width: ScreenWidth, height: titleViewH))
        addSubview(titleView)
        titleView.updateTitle(title: "选择我所在的年级")
    }

    func setupFuctionView() {
        functionView = UIView()
        functionView.backgroundColor = UIColor.white
        addSubview(functionView)
        functionView.frame = CGRect(x: 0, y: headerH + titleViewH, width: ScreenWidth, height: ScreenHeight - headerH - titleViewH)

        // 添加选择年级的view
        let gradeView = GradeChoiceView.init(frame: functionView.bounds) { [weak self] title, tag in

            self?.callBackGrade = title
            // 开始选择年级的动画
            self?.animationOfGrade(tag: tag)

            // 移除年级选择view，出现timeView
            self?.setupTimeView()
        }
        functionView.addSubview(gradeView)
    }

    func setupTimeView() {

        // 移除年级的view
        for item in self.functionView.subviews {
            item.removeFromSuperview()
        }
        self.titleView.updateTitle(title: "选择我的考试时间")
        // 出现时间的选择
        let timeView = TimeChoiceView.init(frame: self.functionView.bounds, callBack: { [weak self] timeString in

            self?.callBackTime = timeString

            // 开始动画
            self?.animationOfTime()

            // 创建分数的view
            self?.setupScoreChoiceView()

        })
        self.functionView.addSubview(timeView)
    }

    func setupScoreChoiceView() {

        // 移除时间的view
        for item in self.functionView.subviews {
            item.removeFromSuperview()
        }
        self.titleView.updateTitle(title: "选择我的目标分数")

        // 创建view
        let scoreView = ScoreChoiceView.init(frame: .zero, dataArray: self.scoresArray, callBack: { [weak self] title, _ in

            self?.callBackScore = title

            // 开始动画
            self?.animationOfScore()

            // 创建是否考过托福的按钮
            self?.setupExamView()
        })
        self.functionView.addSubview(scoreView)
        scoreView.snp.makeConstraints({ make in
            make.left.top.right.equalTo(0)
        })
    }

    func setupExamView() {

        // 移除分数的view
        for item in self.functionView.subviews {
            item.removeFromSuperview()
        }
        self.titleView.updateTitle(title: "是否考过托福")
      
      haveButton = LearnIntentionButton.init(frame: .zero, buttonH: 60, title: haveExamArray[0], selectColor: nil, callBack: { [weak self](title, tag) in
        
        self?.haveExamAnimation(imageName: "LearnIntent_haveExamed")
        
        // 考过的，输入自己曾经的分数
        self?.signInYourScore()
      })
      
      noButton = LearnIntentionButton.init(frame: .zero, buttonH: 60, title: haveExamArray[1], selectColor: UIColor.colorWithHexString("5798ef"), callBack: { [weak self](title, tag) in
        
        self?.callBackExam = title
        self?.haveExamAnimation(imageName: "LearnIntent_noExamed")
        self?.haveButton?.isHidden = true
        // 开启我的托福
        self?.addStartButton()
      })
      functionView.addSubview(haveButton!)
      functionView.addSubview(noButton!)
      haveButton?.snp.makeConstraints({ (make) in
        make.top.equalTo(0)
        make.left.equalTo(60)
        make.right.equalTo(-60)
        make.height.equalTo(60)
      })
      noButton?.snp.makeConstraints({ (make) in
        make.top.equalTo((haveButton?.snp.bottom)!).offset(20)
        make.left.equalTo(60)
        make.right.equalTo(-60)
        make.height.equalTo(60)
      })
      
  }

    func addStartButton() {
        let startButton = UIButton(type: .custom)
        startButton.setTitle("开启我的托福", for: .normal)
        startButton.setTitleColor(UIColor.colorWithHexString("048cff"), for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        startButton.addTarget(self, action: #selector(clickStartButton), for: .touchUpInside)
        functionView.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(functionView.snp.centerX)
            make.bottom.equalTo(functionView.snp.bottom).offset(-45)
        }
    }

    func signInYourScore() {
      scoreTextField?.removeFromSuperview()
      scoreTextField = nil
        scoreTextField = UITextField()
        scoreTextField?.layer.masksToBounds = true
        scoreTextField?.layer.cornerRadius = 2
        scoreTextField?.layer.borderWidth = 1
        scoreTextField?.layer.borderColor = UIColor.colorWithHexString("eaeff2").cgColor
        scoreTextField?.placeholder = "请输入你的考试分数"
        scoreTextField?.textColor = UIColor.colorWithHexString("666666")
        scoreTextField?.textAlignment = .center
        scoreTextField?.keyboardType = .numberPad
        scoreTextField?.delegate = self
        // 数字键盘returnType无效
        scoreTextField?.returnKeyType = .go
        functionView.addSubview(scoreTextField!)
        scoreTextField?.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.height.equalTo(44)
            make.left.equalTo(70)
            make.right.equalTo(functionView.snp.right).offset(-70)
        }

        scoreTextField?.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(textChange), name: NSNotification.Name.UITextFieldTextDidChange, object: scoreTextField)
    }

    func textChange() {
      let scoreInt = Int((scoreTextField?.text)!)
      if scoreInt! > 120 {
        tipIt(tipText: "分数不能超过120")
        scoreTextField?.text = "120"
        
      }

    }

    func clickStartButton() {
        if self.callBackExam == nil {
            tipIt(tipText: "请输入分数")
            return
        }
        // 回调rn
        print("self.callBackGrade ==", self.callBackGrade ?? "")
        print("self.callBackTime ==", self.callBackTime ?? "")
        print("self.callBackScore ==", self.callBackScore ?? "")
        print("self.callBackExam ==", self.callBackExam ?? "")
  
      if callBackToRN != nil {
        callBackToRN!([
          "grade":self.callBackGrade!,
          "time":self.callBackTime!,
          "score":self.callBackScore!,
          "examed":self.callBackExam!,
          ],self)
      }
    }

    func addNormalPerson() {

        personBody = UIImageView()
        personBody.image = UIImage.init(named: "LearnIntent_normal_body")
        headerView.addSubview(personBody)

        personHeader = UIImageView()
        personHeader.image = UIImage.init(named: "LearnIntent_normal_header")
        headerView.addSubview(personHeader)

        personBody.snp.makeConstraints { make in
            make.centerX.equalTo(headerView.snp.centerX)
            make.bottom.equalTo(headerView.snp.bottom)
        }
        personHeader.snp.makeConstraints { make in
            make.centerX.equalTo(headerView.snp.centerX)
            make.bottom.equalTo(personBody.snp.top).offset(13)
        }
    }

    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }

    // MARK: - keybord show and hide
    func keybordWillShow(noti: Notification) {
      
      self.haveButton?.isHidden = true
      self.noButton?.isHidden = true
        let aValue = noti.userInfo![UIKeyboardFrameEndUserInfoKey]
        let keybordFrame = (aValue as AnyObject).cgRectValue as CGRect
        addCoverButton(keyboardSize: keybordFrame.size)
    }
//  func keybordDidHide(noti: Notification) {
//    self.noButton?.isHidden = false
//    self.haveButton?.isHidden = (scoreTextField?.text?.length)! > 0
    
//  }

    func addCoverButton(keyboardSize: CGSize) {
        coverButton?.removeFromSuperview()
        coverButton = nil
        coverButton = UIButton()
        coverButton?.backgroundColor = .clear
        coverButton?.addTarget(self, action: #selector(clickCoverButton), for: .touchUpInside)
        addSubview(coverButton!)
        coverButton?.snp.makeConstraints({ make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(ScreenHeight - keyboardSize.height)
        })
    }

    func clickCoverButton() {
      
        scoreTextField?.resignFirstResponder()
        coverButton?.removeFromSuperview()
        coverButton = nil
      noButton?.isHidden = false
      
      if scoreTextField?.text?.length == 0 {
        scoreTextField?.removeFromSuperview()
        scoreTextField = nil
        haveButton?.isHidden = false
        return
      }
      
      // 开启我的托福
      addStartButton()
      let scoreInt = Int((scoreTextField?.text)!)
        scoreTextField?.text = "\(scoreInt!)分"
        callBackExam = scoreTextField?.text
    }

    // MARK: - tipLabel
    func tipIt(tipText: String) {
        tipLabel?.removeFromSuperview()
        tipLabel = nil
        tipLabel = UILabel()
        tipLabel?.text = tipText
        tipLabel?.backgroundColor = UIColor.colorWithHexString("8e9da6")
        tipLabel?.textColor = .white
        tipLabel?.textAlignment = .center
        tipLabel?.layer.masksToBounds = true
        tipLabel?.layer.cornerRadius = 10
        addSubview(tipLabel!)
        tipLabel?.snp.makeConstraints({ make in
            make.center.equalTo(self.snp.center)
            make.height.equalTo(50)
            make.width.equalTo(200)
        })
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) { 
        self.tipLabel?.removeFromSuperview()
      }
    }

    // MARK: - 考过没考过的动画
    func haveExamAnimation(imageName: String) {
        examCardView?.removeFromSuperview()
        examCardView = nil

        examCardView = UIImageView.init()
        examCardView?.image = UIImage.init(named: imageName)
        examCardView?.layer.opacity = 0
        examCardView?.layer.masksToBounds = true
        headerView.addSubview(examCardView!)
        examCardView?.snp.makeConstraints { make in
            make.right.equalTo(personBody.snp.left).offset(12)
            make.top.equalTo(headerView.snp.bottom)
        }

        let imageSize = examCardView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize)

        UIView.animate(withDuration: gradeAnimateTime - 0.5) {
            self.examCardView?.layer.opacity = 1
            self.examCardView?.transform = CGAffineTransform(translationX: 0, y: 5 - (imageSize?.height)!)
        }
    }

    // MARK: - 选择分数的动画
    func animationOfScore() {
        scoreCardView?.removeFromSuperview()
        scoreCardView = nil
        scoreCardView = UIImageView()
        scoreCardView?.image = UIImage.init(named: "LearnIntent_score")
        scoreCardView?.layer.opacity = 0
        personHeader.addSubview(scoreCardView!)
        scoreCardView?.snp.makeConstraints({ make in
            make.top.equalTo(personHeader.snp.top).offset(2)
            make.right.equalTo(personHeader.snp.right).offset(3)
        })

        let scoreLabel = UILabel()
        scoreLabel.font = UIFont.systemFont(ofSize: 17)
        scoreLabel.text = self.callBackScore
        scoreLabel.textColor = UIColor.white
        scoreLabel.textAlignment = .center
        scoreCardView?.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo((scoreCardView?.snp.centerY)!)
          
          make.centerX.equalTo((scoreCardView?.snp.centerX)!).offset(7)
        }

        UIView.animate(withDuration: gradeAnimateTime) {
            self.scoreCardView?.layer.opacity = 1
        }
    }

    // MARK: - 选择时间的动画
    func animationOfTime() {
        timeCardView?.removeFromSuperview()
        timeCardView = nil

        timeCardView = UIImageView.init()
        timeCardView?.layer.opacity = 0
        timeCardView?.layer.masksToBounds = true
        timeCardView?.image = UIImage.init(named: "LearnIntent_timeCard")
        headerView.addSubview(timeCardView!)
        timeCardView?.snp.makeConstraints { make in
            make.centerX.equalTo(headerView.snp.centerX)
            make.bottom.equalTo(headerView.snp.top)
        }

        let timeLabel = UILabel.init()
        timeLabel.text = self.callBackTime
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        timeLabel.textColor = UIColor.white
        timeCardView?.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalTo((timeCardView?.snp.centerX)!)
            make.bottom.equalTo((timeCardView?.snp.bottom)!).offset(-10)
        }

        let imageSize = timeCardView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize)

        UIView.animate(withDuration: gradeAnimateTime - 0.5) {
            self.timeCardView?.layer.opacity = 1
            self.timeCardView?.transform = CGAffineTransform(translationX: 0, y: (imageSize?.height)!)
        }
    }

    // MARK: - 选择年级的动画
    func animationOfGrade(tag: Int) {

        switch tag {
        case 0:
            // 飞机  铅笔  衣服
            animateLeft(imageName: "LearnIntent_grade0_plane", tag: tag)
            animateRight(imageName: "LearnIntent_grade0_pen", tag: tag)
            animateBody(imageName: "LearnIntent_grade0_body", tag: tag)
        case 1:
            // 时间  书  衣服  眼睛
            animateLeft(imageName: "LearnIntent_grade1_time", tag: tag)
            animateRight(imageName: "LearnIntent_grade1_book", tag: tag)
            animateBody(imageName: "LearnIntent_grade1_body", tag: tag)
            animateHead(imageName: "LearnIntent_grade1_glass", tag: tag)
        case 2:
            // 对话框  鼠标  衣服 耳机
            animateLeft(imageName: "LearnIntent_grade2_left", tag: tag)
            animateRight(imageName: "LearnIntent_grade2_mouse", tag: tag)
            animateBody(imageName: "LearnIntent_grade2_body", tag: tag)
            animateHead(imageName: "LearnIntent_grade2_ear", tag: tag)
        case 3:
            // 毕业证  勋章  衣服 帽子
            animateLeft(imageName: "LearnIntent_grade3_left", tag: tag)
            animateRight(imageName: "LearnIntent_grade3_right", tag: tag)
            animateBody(imageName: "LearnIntent_grade3_body", tag: tag)
            animateHead(imageName: "LearnIntent_grade3_hat", tag: tag)
        case 4:
            // 公文包  茶  衣服
            animateLeft(imageName: "LearnIntent_grade4_left", tag: tag)
            animateRight(imageName: "LearnIntent_grade4_tea", tag: tag)
            animateBody(imageName: "LearnIntent_grade4_body", tag: tag)
        default:
            print("")
        }
    }

    func animateLeft(imageName: String, tag: Int) {
        gradeLeftImageView?.removeFromSuperview()
        gradeLeftImageView = nil
        gradeLeftImageView = UIImageView()
        gradeLeftImageView?.layer.opacity = 0
        headerView.addSubview(gradeLeftImageView!)
        gradeLeftImageView?.image = UIImage.init(named: imageName)

        let imageW: CGFloat = 58
        var imageH: CGFloat = 68
        if tag == 4 {
            imageH = 47
            gradeLeftImageView?.frame = CGRect(x: -imageW,
                                               y: headerH - imageH,
                                               width: imageW,
                                               height: imageH)
            UIView.animate(withDuration: gradeAnimateTime) {
                self.gradeLeftImageView?.layer.opacity = 1
                self.gradeLeftImageView?.frame.origin.x = ScreenWidth / 2 - imageW - 30
            }

        } else {
            gradeLeftImageView?.frame = CGRect(x: -imageW,
                                               y: headerView.center.y,
                                               width: imageW,
                                               height: imageH)
            UIView.animate(withDuration: gradeAnimateTime) {
                self.gradeLeftImageView?.layer.opacity = 1
                self.gradeLeftImageView?.frame.origin.x += (70 + imageW)
            }
        }
    }

    func animateBody(imageName: String, tag _: Int) {
        gradeBodyImageView?.removeFromSuperview()
        gradeBodyImageView = nil
        gradeBodyImageView = UIImageView()
        gradeBodyImageView?.image = UIImage.init(named: imageName)
        gradeBodyImageView?.frame = personBody.bounds
        gradeBodyImageView?.layer.opacity = 0
        personBody.addSubview(gradeBodyImageView!)
        UIView.animate(withDuration: gradeAnimateTime) {
            self.gradeBodyImageView?.layer.opacity = 1
        }
    }

    func animateHead(imageName: String, tag: Int) {
        gradeHeaderImageView?.removeFromSuperview()
        gradeHeaderImageView = nil
        gradeHeaderImageView = UIImageView()
        gradeHeaderImageView?.image = UIImage.init(named: imageName)
        gradeHeaderImageView?.layer.opacity = 0
        personHeader.addSubview(gradeHeaderImageView!)
        switch tag {
        case 1:
            gradeHeaderImageView?.snp.makeConstraints({ make in
                make.centerX.equalTo(personHeader.snp.centerX)
                make.centerY.equalTo(personHeader.snp.centerY).offset(0)
            })
        case 2:
            gradeHeaderImageView?.snp.makeConstraints({ make in
                make.centerX.equalTo(personHeader.snp.centerX)
                make.top.equalTo(personHeader.snp.top)
            })
        case 3:
            gradeHeaderImageView?.snp.makeConstraints({ make in
                make.centerX.equalTo(personHeader.snp.centerX)
                make.centerY.equalTo(personHeader.snp.top).offset(10)
            })

        default:
            print("")
        }
        UIView.animate(withDuration: gradeAnimateTime) {
            self.gradeHeaderImageView?.layer.opacity = 1
        }
    }

    func animateRight(imageName: String, tag: Int) {
        gradeRightImageView?.removeFromSuperview()
        gradeRightImageView = nil
        gradeRightImageView = UIImageView()
        gradeRightImageView?.layer.opacity = 0
        headerView.addSubview(gradeRightImageView!)
        gradeRightImageView?.image = UIImage.init(named: imageName)
        let imageW: CGFloat = 50
        let imageH: CGFloat = 52
        let delay = TimeInterval(0.5)
        if tag == 4 {
            gradeRightImageView?.frame = CGRect(x: ScreenWidth,
                                                y: headerH - imageH,
                                                width: imageW,
                                                height: imageH)

        } else {

            gradeRightImageView?.frame = CGRect(x: ScreenWidth,
                                                y: headerH - imageH - 20,
                                                width: imageW,
                                                height: imageH)
        }
        UIView.animate(withDuration: gradeAnimateTime - delay, delay: delay, options: .curveLinear, animations: {
            self.gradeRightImageView?.layer.opacity = 1
            self.gradeRightImageView?.frame.origin.x = ScreenWidth / 2 + 50
        }) { _ in
        }
    }

    deinit {
        print("-----------------------------")
        print("LearnIntentionView deinit")
        NotificationCenter.default.removeObserver(self)
        if scoreTextField != nil {
          NotificationCenter.default.removeObserver(scoreTextField!)
        }
    }
}
