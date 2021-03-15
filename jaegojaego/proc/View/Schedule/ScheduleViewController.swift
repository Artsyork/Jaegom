import UIKit
import Foundation
import FSCalendar

class ScheduleViewController : UIViewController {
    @IBOutlet weak var calendar_table: UITableView! {
        didSet {
            calendar_table.dataSource = self
            calendar_table.delegate = self
        }
    }
    @IBOutlet weak var ourCalendar: FSCalendar!
    
    private let viewModel = ScheduleViewModel()
    private var selectedDate = ""
    private var filteredData: [Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpReloadData()
    }
}


extension ScheduleViewController {
    private func setUpNavigationBar(){
        if let bar = navigationController?.navigationBar {
            bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            bar.shadowImage = UIImage()
            bar.backgroundColor = UIColor.clear
        }
    }
    
    private func setUpReloadData(){
        selectedDate = Date().returnString(format: "yyyyMMdd")
        filteredData = viewModel.returnScheduleAt(date: selectedDate)
        ourCalendar.reloadData()
        calendar_table.reloadData()
        calendar_table.separatorStyle = .none
    }
}


extension ScheduleViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "littleScheduleCell", for: indexPath) as! ScheduleLittleTableCell
        cell.bindViewModel(title: filteredData[indexPath.row] .scheduleTitle)
        return cell
    }
    
    // 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let schedule = viewModel.findSchedule(index: indexPath.row)
        
        viewModel.removeSchedule(data: schedule)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        calendar_table.reloadData()
    }
}

extension ScheduleViewController : FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition){
        let dateString = date.returnString(format: "yyyyMMdd")
        let dateArray = viewModel.returnScheduleDateArray()
        
        for dateIndex in dateArray {
            if dateString == dateIndex {
                cell.eventIndicator.numberOfEvents = 1
                cell.eventIndicator.isHidden = false
                cell.eventIndicator.color = UIColor.blue
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = date.returnString(format: "yyyyMMdd")
        let dateArray = viewModel.returnScheduleDateArray()
        if dateArray.contains(dateString){
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date.returnString(format: "yyyyMMdd")
        filteredData = viewModel.returnScheduleAt(date: selectedDate)
        calendar_table.reloadData()
    }
}
