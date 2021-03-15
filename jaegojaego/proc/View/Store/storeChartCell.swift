import Foundation
import UIKit

class storeChartCell : UITableViewCell {
    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var labelSaveStyle:UIImageView!
    @IBOutlet weak var ChartImage:UIImageView!
    @IBOutlet weak var labelDownDate:UILabel!
    @IBOutlet weak var labelMany:UILabel!
    
    func bindViewModel(store: Store){
        DispatchQueue.main.async { [weak self] in
            self?.labelSaveStyle.image = UIImage(named: store.saveStyle.rawValue)
            self?.ChartImage.image = UIImage(named: store.Image)
        }
        labelName.text = store.name
        labelDownDate.text = store.DownDate.returnString(format: "yyyy. MM. dd")
        labelMany.text = "\(store.many)\(store.manytype)"
    }
}
