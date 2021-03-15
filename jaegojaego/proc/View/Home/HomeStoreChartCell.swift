import UIKit
import Foundation

class HomeStoreChartCell:UITableViewCell {
    @IBOutlet weak var HomeStoreName: UILabel! // 이름
    @IBOutlet weak var HomeStoreSaveStyle:UILabel! // 저장방법
    
    @IBOutlet weak var HomeStoreMany: UILabel! // 수량
    @IBOutlet weak var HomeStoreImage: UIImageView! // 저장방법 아이콘
    
    func bindViewModel(stock: Store) {
        DispatchQueue.main.async { [weak self] in
            self?.HomeStoreImage.image = UIImage(named: stock.saveStyle.rawValue)
        }
        HomeStoreName.text = stock.name
        HomeStoreMany.text = "\(stock.many) / \(stock.TotalMany)\(stock.manytype)"
    }
}
