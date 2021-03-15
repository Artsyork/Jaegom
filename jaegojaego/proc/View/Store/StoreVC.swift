//
//  StoreVC.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit
import Foundation

protocol StoreVCDelegate {
    func updateStoreData()
}

class StoreVC: UIViewController {
    @IBOutlet weak var storeListTV: UITableView! {
        didSet {
            storeListTV.delegate = self
            storeListTV.dataSource = self
        }
    }
    @IBOutlet weak var storeSearchBar: UISearchBar! {
        didSet {
            storeSearchBar.delegate = self
        }
    }
    @IBOutlet weak var editBtn: UIButton!
    @IBAction func plusBtn(_ sender: UIButton) {
        goToAddStoreVC()
    }
    
    private let viewModel = StoreViewModel()
    private let buttonBar = UIView()
    
    private var switchSegment = UISegmentedControl()
    private var (selectSegmentNumber, selectIndex) = (0,0)
    private var searchArray : [Int : [Store]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpSegmentBar()
        setUpSearchArray()
        setUpButtonLayoutSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storeListTV.reloadData()
    }
}


extension StoreVC : UISearchBarDelegate {
    private func setUpSubViews(){
        storeListTV.separatorStyle = .none
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addSubview(buttonBar)
        view.addSubview(switchSegment)
        view.addGestureRecognizer(tap)
        
        switchSegment.addTarget(self, action: #selector(StoreVC.segmentControlValueChanged(_:)), for: UIControl.Event.valueChanged)
        editBtn.addTarget(self, action: #selector(editBtnClicked), for: .touchUpInside)
    }

    private func setUpSearchArray(){
        viewModel.returnStockTotalCount()
        
        searchArray.updateValue(viewModel.returnStockUntilDate(fromDays: -1, toDays: 0), forKey: 0)
        searchArray.updateValue(viewModel.returnStockUntilDate(fromDays: 0, toDays: 1), forKey: 1)
        searchArray.updateValue(viewModel.returnStockUntilDate(fromDays: 2, toDays: nil), forKey: 2)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch searchText.isEmpty {
        case true :
            searchArray[0] = viewModel.returnChartModel(index: 0)
            searchArray[1] = viewModel.returnChartModel(index: 1)
            searchArray[2] = viewModel.returnChartModel(index: 2)
        case false :
            searchArray[0] = viewModel.returnChartModel(index: 0).filter { $0.name.range(of: searchText) != nil }
            searchArray[1] = viewModel.returnChartModel(index: 1).filter { $0.name.range(of: searchText) != nil }
            searchArray[2] = viewModel.returnChartModel(index: 2).filter { $0.name.range(of: searchText) != nil }
        }
        
        storeListTV.reloadData()
    }

    private func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        storeSearchBar.text = ""
        storeSearchBar.resignFirstResponder()
        storeSearchBar.showsCancelButton = false
        storeListTV.reloadData()
    }
        
    @objc private func editBtnClicked() {
        switch storeListTV.isEditing {
        case true:
            editBtn.setTitle("Edit", for: .normal)
            storeListTV.setEditing(false, animated: true)
        case false:
            editBtn.setTitle("Done", for: .normal)
            storeListTV.setEditing(true, animated: true)
        }
    }
}


// 테이블 뷰
extension StoreVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = searchArray[selectSegmentNumber] else { return 1 }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let array = searchArray[selectSegmentNumber] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreChartCell") as! storeChartCell
        cell.bindViewModel(store: array[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let array = searchArray[selectSegmentNumber] {
            selectIndex = viewModel.findStockAsStock(data: array[indexPath.row])
            goToStorePopupVC()
        }
    }
    
    // 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard var array = searchArray[selectSegmentNumber] else { return }
            array.remove(at: indexPath.row)
            viewModel.removeStock(data: viewModel.findStockAsStock(data: array[indexPath.row]))
            storeListTV.deleteRows(at: [indexPath], with: .automatic)
            viewModel.saveData()
            updateStoreData()
        }
    }
}



// 세그먼트
extension StoreVC : StoreVCDelegate {
    func updateStoreData() {
        storeListTV.reloadData()
    }
    
    private func setUpSegmentBar(){
        switchSegment.insertSegment(withTitle: "폐기 물품", at: 0, animated: true)
        switchSegment.insertSegment(withTitle: "당일 마감", at: 1, animated: true)
        switchSegment.insertSegment(withTitle: "양호 물품", at: 2, animated: true)
        switchSegment.selectedSegmentIndex = selectSegmentNumber
        switchSegment.translatesAutoresizingMaskIntoConstraints = false
        
        switchSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: storeSearchBar.bounds.height).isActive = true
        switchSegment.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        switchSegment.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        switchSegment.backgroundColor = .clear
        switchSegment.tintColor = .clear
        switchSegment.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DiwanMishafi", size: 16)!,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        switchSegment.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "DiwanMishafi", size : 18)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.26, green: 0.43, blue: 0.85, alpha: 1.0)], for: .selected)
    }
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl){
        let segNum = switchSegment.selectedSegmentIndex
        let buttonBarFrame = switchSegment.bounds.width / CGFloat(3) * CGFloat(segNum)

        UIView.animate(withDuration: 0.3){ [weak self] in
            self?.buttonBar.frame.origin.x = buttonBarFrame
            self?.selectSegmentNumber = segNum
        }
        
        storeListTV.reloadData()
    }

    private func setUpButtonLayoutSetting(){
        buttonBar.backgroundColor = UIColor(red: 0.26, green: 0.43, blue: 0.85, alpha: 1.0)
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.topAnchor.constraint(equalTo: switchSegment.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: switchSegment.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: switchSegment.widthAnchor, multiplier: 1 / CGFloat(switchSegment.numberOfSegments)).isActive = true
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }

    private func goToStorePopupVC(){
        let vc : StorePopupVC = storyboard?.instantiateViewController(withIdentifier: "storePopupVC") as! StorePopupVC
        vc.position = selectIndex
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: true)
    }
    
    private func goToAddStoreVC(){
        let vc : AddStoreVC = storyboard?.instantiateViewController(withIdentifier: "addStoreVC") as! AddStoreVC
        vc.delegate = self
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
}
