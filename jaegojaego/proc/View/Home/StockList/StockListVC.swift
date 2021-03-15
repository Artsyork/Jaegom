//
//  StockListVC.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class StockListVC: UIViewController {
    @IBOutlet weak var stockCollectionView: UICollectionView! {
        didSet {
            stockCollectionView.delegate = self
            stockCollectionView.dataSource = self
            stockCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            stockCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        stockCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension StockListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return indexPath.row % 2 == 0 ?
            newCollectionSetting(stockCollectionView, indexpath: indexPath) :
            outCollectionSetting(stockCollectionView, indexpath: indexPath)
    }
    
    // 입고 목록 세팅
    func newCollectionSetting(_ collectionView : UICollectionView, indexpath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionCell", for: indexpath) as! newStockCollectionCell
        return cell
    }
    
    // 출고 목록 세팅
    func outCollectionSetting(_ collectionView: UICollectionView, indexpath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutCollectionCell", for: indexpath) as! outStockCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
}


extension StockListVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 30
        let height = self.view.frame.height - (80 * 2)
        return CGSize(width: width, height: height)
    }
}
