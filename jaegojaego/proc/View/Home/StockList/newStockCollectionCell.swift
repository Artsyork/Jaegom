//
//  newStockCollectionCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

struct SectionObjects {
    var sectionDate : Date!
    var sectionStock : [Store]!
}

class newStockCollectionCell: UICollectionViewCell {
    @IBOutlet weak var newStockTV: UITableView! {
        didSet {
            newStockTV.delegate = self
            newStockTV.dataSource = self
            newStockTV.showsVerticalScrollIndicator = false
        }
    }
    
    private let viewModel = StoreViewModel()
    private var sectionArray : [SectionObjects] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSubViews()
        setUpArray()
    }
}


extension newStockCollectionCell {
    private func setUpSubViews(){
        setSubLayer()
        
        newStockTV.register(UINib(nibName: "StockTitleTableCell", bundle: nil), forCellReuseIdentifier: StockTitleTableCell.titleTableCellID)
        newStockTV.register(UINib(nibName: "StockSubTitleTableCell", bundle: nil), forCellReuseIdentifier: StockSubTitleTableCell.subTitleTableCellID)
    }
    
    private func setUpArray() {
        let array = viewModel.returnStockPerDateBuyArray()
        for (key, value) in array {
            sectionArray.append(SectionObjects(sectionDate: key, sectionStock: value))
        }
        sectionArray.sort(by: {$0.sectionDate > $1.sectionDate})
    }
}


extension newStockCollectionCell : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray[section].sectionStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = sectionArray[indexPath.section].sectionStock[indexPath.row]
        let cell = newStockTV.dequeueReusableCell(withIdentifier: StockSubTitleTableCell.subTitleTableCellID, for: indexPath) as! StockSubTitleTableCell
            
        cell.bindViewModel(stockName: state.name, stockCount: state.many, stockType: state.manytype)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTitleTableCell.titleTableCellID) as! StockTitleTableCell
     
        let many = sectionArray[section].sectionStock.map { $0.many }.reduce(0, +)
        cell.bindViewModel(stockDate: sectionArray[section].sectionDate,
                                 stockTotal: many,
                                 stockImage: true)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
    
}
