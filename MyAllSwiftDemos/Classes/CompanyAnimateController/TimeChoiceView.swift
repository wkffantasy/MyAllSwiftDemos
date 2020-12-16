//
//  TimeChoiceView.swift
//  toeflios
//
//  Created by fantasy on 17/5/26.
//  Copyright © 2017年 Facebook. All rights reserved.
//

import UIKit

class TimeChoiceView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    typealias CallBackBlock = (String) -> Void

    public var callBack: CallBackBlock?

    private var headerView: UIView!
    private var containView: UIView!

    private var yearPickerView: UIPickerView!
    private var monthPickerView: UIPickerView!
    private var dayPickerView: UIPickerView!

    let headerH: CGFloat = 20

    private var thisYear: Int!
  private var thisMonth: Int!
  private var thisDay: Int!

    init(frame: CGRect,
         callBack: @escaping CallBackBlock) {
        super.init(frame: frame)
        self.callBack = callBack

        addTimeView()
        addButton()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addTimeView() {

        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year, .month, .day], from: Date())

        thisYear = comps.year!
        thisMonth = comps.month!
        thisDay = comps.day!

        yearPickerView = UIPickerView()
        yearPickerView.dataSource = self
        yearPickerView.delegate = self
        addSubview(yearPickerView)
        yearPickerView.frame = CGRect(x: 0, y: 15, width: ScreenWidth / 3, height: 150)
        let yearLabel = createLabel(text: "年")
        yearLabel.snp.makeConstraints { make in
            make.bottom.equalTo(yearPickerView.snp.top)
            make.centerX.equalTo(yearPickerView.snp.centerX)
        }

        monthPickerView = UIPickerView()
        monthPickerView.dataSource = self
        monthPickerView.delegate = self
        addSubview(monthPickerView)
        monthPickerView.frame = CGRect(x: ScreenWidth / 3, y: 15, width: ScreenWidth / 3, height: 150)
        let monthLabel = createLabel(text: "月")
        monthLabel.snp.makeConstraints { make in
            make.bottom.equalTo(monthPickerView.snp.top)
            make.centerX.equalTo(monthPickerView.snp.centerX)
        }
        dayPickerView = UIPickerView()
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
        addSubview(dayPickerView)
        dayPickerView.frame = CGRect(x: 2 * ScreenWidth / 3, y: 15, width: ScreenWidth / 3, height: 150)
        let dayLabel = createLabel(text: "日")
        dayLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dayPickerView.snp.top)
            make.centerX.equalTo(dayPickerView.snp.centerX)
        }
      //到今天这一天
      DispatchQueue.main.async {
        self.yearPickerView.selectRow(1, inComponent: 0, animated: true)
        DispatchQueue.main.async {
          self.monthPickerView.reloadAllComponents()
          DispatchQueue.main.async {
            self.dayPickerView.reloadAllComponents()
          }
        }
      }
     
    }

    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.colorWithHexString("8e9da6")
        label.font = UIFont.systemFont(ofSize: 12)
        addSubview(label)
        return label
    }

    func addButton() {
        let confirmButton = UIButton(type: .custom)
        confirmButton.setTitle("确定好时间了", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        confirmButton.setTitleColor(UIColor.colorWithHexString("2b97ff"), for: .normal)
        addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(yearPickerView.snp.bottom)
            make.bottom.equalTo(0)
            make.centerX.equalTo(self.snp.centerX)
        }
        confirmButton.addTarget(self, action: #selector(getPickerViewInfo), for: .touchUpInside)
    }

    @objc func getPickerViewInfo() {
      var year = ""
      var month = ""
      var day = ""
      let yearRow = yearPickerView.selectedRow(inComponent: 0)
      let monthRow = monthPickerView.selectedRow(inComponent: 0)
      let dayRow = dayPickerView.selectedRow(inComponent: 0)
      if yearRow == 0 {
        if callBack != nil {
          callBack!("待定")
        }
      } else if (yearRow == 1){
        year = "\(thisYear+yearRow-1)"
        month = "\(thisMonth+monthRow)"
        if dayRow == 0 {
          day = "\(thisDay+dayRow)"
        } else {
          day = "\(dayRow+1)"
        }
      } else {
        year = "\(thisYear+yearRow-1)"
        month = "\(monthRow+1)"
        day = "\(dayRow+1)"
      }
     
      let callBackString = year + "-" + month + "-" + day
      if callBack != nil {
        callBack!(callBackString)
      }
    }

    // MARK: - delegate and dataSource
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, rowHeightForComponent _: Int) -> CGFloat {
        return 40
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        switch pickerView {
        case yearPickerView:
            return 3
        case monthPickerView:
          let yearRow = yearPickerView.selectedRow(inComponent: 0)
          if yearRow == 0 {
            return 1
          } else if (yearRow == 1){
            return 12 - thisMonth + 1
          } else {
            return 12
          }
        case dayPickerView:
          let yearRow = yearPickerView.selectedRow(inComponent: 0)
          let monthRow = monthPickerView.selectedRow(inComponent: 0)
          if yearRow == 0 {
            return 1
          } else if (yearRow == 1) {
            let thisMonthDay = getTotalDays(year: thisYear+yearRow-1, imonth: monthRow+thisMonth)
            if monthRow == 0 {
              return thisMonthDay - thisDay + 1
            } else {
              return thisMonthDay
            }
          }
          let thisMonthDay = getTotalDays(year: thisYear+yearRow-1, imonth: monthRow+1)
          return thisMonthDay
        default:
            return 12
        }
      return 12
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent _: Int, reusing _: UIView?) -> UIView {
      
        var title = ""
        switch pickerView {
        case yearPickerView:
            if row == 0 {
                title = "待定"
            } else {
                title = "\(thisYear + row - 1)"
            }
        case monthPickerView:
          let yearRow = yearPickerView.selectedRow(inComponent: 0)
          if yearRow == 0 {
            title = "--"
          } else if (yearRow == 1){
            title = "\(row + thisMonth)"
          } else {
            title = "\(row + 1)"
          }
        case dayPickerView:
          let yearRow = yearPickerView.selectedRow(inComponent: 0)
          let monthRow = monthPickerView.selectedRow(inComponent: 0)
          if yearRow == 0 {
            title = "--"
          } else if (yearRow == 1) {
            if monthRow == 0 {
              title = "\(thisDay + row)"
            } else {
              title = "\(row + 1)"
            }
          } else {
            title = "\(row + 1)"
          }
        default:
            title = "-----"
        }

        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.colorWithHexString("2f3136")
        pickerLabel.text = title
        pickerLabel.font = UIFont.systemFont(ofSize: 18)
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    switch pickerView {
    case dayPickerView:
      print("row")
    case monthPickerView:
      selectRowInMonthPickerView(row:row)
    case yearPickerView:
      selectRowInYearPickerView(row: row)
    default:
      print("")
    }
  }
  // did select monthPickerView row
  func selectRowInMonthPickerView(row:Int) {
    dayPickerView.reloadAllComponents()
  }
  
  //did select yearPickerView row
  func selectRowInYearPickerView(row:Int) {
    monthPickerView.reloadAllComponents()
    DispatchQueue.main.async {
      self.dayPickerView.reloadAllComponents()
    }
    switch row {
    case 0:
      monthPickerView.selectRow(0, inComponent: 0, animated: true)
      dayPickerView.selectRow(0, inComponent: 0, animated: true)
    case 1:
      print("")
    case 2:
      print("")
    default:
      print("can not be this condition")
    }
  }
  //get all days according year and month
  func getTotalDays(year:Int,imonth:Int) -> Int {
    
    if((imonth == 0)||(imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12)){
      
      return 31;
    }
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11)){
      
      return 30;
    }
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
      return 28;
    }
    if(year%400 == 0){
      
      return 29;
    }
    if(year%100 == 0){
      
      return 28;
    }
    return 29;
  }
}
