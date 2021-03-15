//
//  StorePopupVC.swift
//  proc
//
//  Created by 성다연 on 2019. 2. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class StorePopupVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var pop_nameLabel: UILabel!
    @IBOutlet weak var pop_manyLabel: UILabel!
    @IBOutlet weak var pop_TF: UITextField!
    @IBAction func pop_cancleBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBOutlet weak var pop_completeBtn: UIButton!
    
    private let viewModel = StoreViewModel()
    private var item : Store?
    var delegate : StoreVCDelegate?
    var position : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubView()
    }
}


extension StorePopupVC {
    private func setUpSubView(){
        item = viewModel.findStockAsInt(data: position)
        pop_nameLabel.text = "제품명 : \(item!.name)"
        pop_manyLabel.text = "현재 수량 : \(item!.many) \(item!.manytype)"
        
        pop_TF.becomeFirstResponder()
        pop_completeBtn.addTarget(self, action: #selector(isItemUsed), for: .touchUpInside)
    }
    
    @objc private func isItemUsed(){
        guard let usedItem = pop_TF.text else {
            ToastView.shared.short(self.view, txt_msg: "사용한 개수를 입력해주세요.")
            return
        }
        let item = viewModel.findStockAsInt(data: position)
        
        if usedItem.isNumber && item.many - Int(usedItem)! >= 0  {
            item.many -= Int(usedItem)!

            if item.many <= 0 {
                item.DownDate = DateFormatter().date(from: Date().returnString(format: "yyyy.MM.dd"))!
            }
            
            let stock = Store(name: item.name, UpDate: item.UpDate, DownDate: item.DownDate, many: Int(usedItem)!, manytype:  item.manytype, saveStyle: item.saveStyle)
                    
            viewModel.addStock(data: stock)
            viewModel.returnStockTotalCount()
            viewModel.saveData()
            delegate?.updateStoreData()
            dismiss(animated: true)
        } else {
            ToastView.shared.short(self.view, txt_msg: "가지고 있는 수량보다 개수가 많거나 숫자가 아닙니다!")
        }
    }
}
