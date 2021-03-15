import UIKit

class HomeStoreTableViewController : UITableViewController {
    private let viewModel = StoreViewModel()
    private var homeStoreFilterByMany: [Store] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    private func setUpArray() {
        homeStoreFilterByMany = viewModel.returnStockLessItem()
    }
}


extension HomeStoreTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeStoreFilterByMany.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell: HomeStoreChartCell = tableView.dequeueReusableCell(withIdentifier: "HStoreCell") as! HomeStoreChartCell
        cell.bindViewModel(stock: homeStoreFilterByMany[indexPath.row])
        return cell
    }
}
