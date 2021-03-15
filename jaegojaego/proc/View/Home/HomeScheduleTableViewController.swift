import UIKit
import Foundation

class HomeScheduleTableViewController : UITableViewController {
    private let viewModel = ScheduleViewModel()
    // 출력하는 섹션 개수
    private var filterdata = [Schedule]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterdata = viewModel.returnScheduleAt(date: Date().returnString(format: "yyyyMMdd"))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdata.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:HomeScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HScheduleCell") as! HomeScheduleTableViewCell
        cell.bindViewModel(text: viewModel.findSchedule(index: indexPath.row).scheduleTitle)
        return cell
    }
}
