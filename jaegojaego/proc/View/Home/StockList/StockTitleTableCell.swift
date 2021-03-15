//
//  newStockCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 23..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class StockTitleTableCell: UITableViewCell {
    @IBOutlet weak var stockImageView: UIImageView!
    @IBOutlet weak var stockTotalCountLabel: UILabel!
    @IBOutlet weak var stockDateLabel: UILabel!
    
    static let titleTableCellID = "stockTitleTableCell"
    
    func bindViewModel(stockDate: Date, stockTotal: Int, stockImage: Bool){
        DispatchQueue.main.async { [weak self] in
            self?.stockImageView.image = stockImage ? UIImage(named: "downloadImg") : UIImage(named: "uploadImg")
        }
        stockTotalCountLabel.text = "총 \(stockTotal)개"
        stockDateLabel.text = stockDate.returnString(format: "yyyy. MM. dd")
    }
}

