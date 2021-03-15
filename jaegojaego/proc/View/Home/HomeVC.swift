 
 import UIKit
 import Foundation
 import FSCalendar
 
 class HomeViewController: UIViewController {
    @IBOutlet weak var needLabelView: UIView! {
        didSet {
            needLabelView.layoutSubviews()
            needLabelView.layer.cornerRadius = 15
            needLabelView.layer.borderColor = UIColor.init(hex: "#85BECA").cgColor
            needLabelView.layer.borderWidth = 3
        }
    }
    @IBOutlet weak var noticeScheduleView: UIView!
    @IBOutlet weak var noticeNeedTV: UITableView! {
        didSet {
            noticeNeedTV.delegate = self
            noticeNeedTV.dataSource = self
            noticeNeedTV.rowHeight = UITableView.automaticDimension
            noticeNeedTV.estimatedRowHeight = UITableView.automaticDimension
        }
    }
    @IBOutlet weak var noticeScheduleTV: UITableView! {
        didSet {
            noticeScheduleTV.delegate = self
            noticeScheduleTV.dataSource = self
            noticeScheduleTV.rowHeight = UITableView.automaticDimension
            noticeScheduleTV.estimatedRowHeight = UITableView.automaticDimension
        }
    }
    @IBOutlet weak var noticeTodayDate :UILabel! {
        didSet {
            noticeTodayDate.text = Date().returnString(format: "MM월 dd일")
        }
    }
   
    private let storeViewModel = StoreViewModel()
    private let scheduleViewModel = ScheduleViewModel()
    private var homeStoreArray : [Store] = []
    private var homeScheduleArray : [Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setArrayValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloading()
    }
}
 
 extension HomeViewController {
    private func setArrayValues(){
        homeStoreArray = storeViewModel.returnStockLessItem()
        homeScheduleArray = scheduleViewModel.returnScheduleAt(date: Date().returnString(format: "yyyyMMdd"))
    }
    
    func reloading(){
        noticeNeedTV.reloadData()
        noticeScheduleTV.reloadData()
    }
 }
 
 
 extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == noticeNeedTV ? homeStoreArray.count : homeScheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == noticeNeedTV {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HStoreCell") as! HomeStoreChartCell
            cell.bindViewModel(stock: homeStoreArray[indexPath.row])
            return cell
        } else {
            let cell:HomeScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HScheduleCell") as! HomeScheduleTableViewCell
            cell.bindViewModel(text: homeScheduleArray[indexPath.row].scheduleTitle)
            return cell
        }
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == noticeNeedTV ? 56.0 : 50.0
    }
 }

