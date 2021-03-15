//
//  outStockCollectionCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class outStockCollectionCell: UICollectionViewCell {
    @IBOutlet weak var outStockTV: UITableView! {
        didSet {
            outStockTV.delegate = self
            outStockTV.dataSource = self
            outStockTV.showsVerticalScrollIndicator = false
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


extension outStockCollectionCell {
    private func setUpSubViews(){
        setSubLayer()
        
        outStockTV.register(UINib(nibName: "StockTitleTableCell", bundle: nil), forCellReuseIdentifier: StockTitleTableCell.titleTableCellID)
        outStockTV.register(UINib(nibName: "StockSubTitleTableCell", bundle: nil), forCellReuseIdentifier: StockSubTitleTableCell.subTitleTableCellID)
    }
    
    private func setUpArray(){
        let dic = viewModel.returnStockPerDateOutArray()
        for (key, value) in dic {
            sectionArray.append(SectionObjects(sectionDate: key, sectionStock: value))
        }
        /// 나중에 출고 목록을 만들어서 보내줘야함 (사용하면 보내지도록)
        sectionArray.sort(by: { $0.sectionDate > $1.sectionDate })
    }
}


extension outStockCollectionCell : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return sectionArray[section].sectionStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = sectionArray[indexPath.section].sectionStock[indexPath.row]
        let cell = outStockTV.dequeueReusableCell(withIdentifier: StockSubTitleTableCell.subTitleTableCellID, for: indexPath) as! StockSubTitleTableCell
            
        cell.bindViewModel(stockName: state.name, stockCount: state.many, stockType: state.manytype)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTitleTableCell.titleTableCellID) as! StockTitleTableCell

        let many = sectionArray[section].sectionStock.map { $0.many }.reduce(0, +)
        cell.bindViewModel(stockDate: sectionArray[section].sectionDate,
                                 stockTotal: many,
                                 stockImage: false)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
}
