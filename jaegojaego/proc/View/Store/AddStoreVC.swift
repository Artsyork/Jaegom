//
//  AddStoreVC.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 29..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class AddStoreVC: UIViewController {
    @IBOutlet weak var stockPickerView: UIView!
    @IBOutlet weak var saveStyleView: UIView!
    
    @IBOutlet weak var stockDateLabel: UILabel!
    @IBOutlet weak var stockNameTF: UITextField!
    @IBOutlet weak var stockManyTF: UITextField!
    @IBOutlet weak var stockManyTypeTF: UITextField!
    @IBOutlet weak var stockDatePK: UIDatePicker!
    @IBOutlet weak var saveBtn: UIButton!
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private let viewModel = StoreViewModel()
    private var stockDate = Date()
    private var stockType = SaveStyle.Fresh
    private var dataFilePath : String?
    var delegate : StoreVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubViews()
        setUpSegment()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension AddStoreVC {
    private func setSubViews(){
        stockDatePK.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)
        saveBtn.addTarget(self, action: #selector(addStock), for: .touchUpInside)
    }
    
    private func setUpSegment(){
        let saveTypeSegmentControl = BetterSegmentedControl(
            frame: CGRect(x: 35, y: 40, width: view.bounds.width - 70, height: 56),
            segments: LabelSegment.segments(withTitles: ["실온", "냉장", "냉동"],
            normalBackgroundColor: .white,
            normalTextColor: UIColor.init(hex: "#7396D0"),
            selectedBackgroundColor: UIColor.init(hex: "#7396D0"),
            selectedTextColor: .white),
            index: 0,
            options: [.backgroundColor(UIColor.init(hex: "#7396D0")), .indicatorViewBackgroundColor(.white)])
        
        saveTypeSegmentControl.layer.borderWidth = 3
        saveTypeSegmentControl.layer.borderColor = UIColor.init(hex: "#7396D0").cgColor
        saveTypeSegmentControl.layer.cornerRadius = 7
        saveTypeSegmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        saveStyleView.addSubview(saveTypeSegmentControl)
    }
}


extension AddStoreVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, up: false)
    }
    
    private func moveTextField(textfield: UITextField, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? 250 : -250)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}



extension AddStoreVC {
    @objc private func segmentValueChanged(sender: BetterSegmentedControl){
        switch sender.index {
        case 0:
            stockType = SaveStyle.Fresh
        case 1:
            stockType = SaveStyle.Cold
        default:
            stockType = SaveStyle.Ice
        }
    }
    
    @objc private func getDateFromPicker() {
        stockDate = stockDatePK.date
        stockDateLabel.text = stockDate.returnString(format: "yyyy년 MM월 dd일")
    }

    @objc private func addStock(sender: UIButton){
        guard let stockName = stockNameTF.text,
              let stockMany = stockManyTF.text,
              let stockManyType = stockManyTypeTF.text else { return }
        
        /// 나중에 기본 값으로 빠르게 넘어가는 걸로 변경
        if stockName.isEmpty == false && stockMany.isEmpty == false && stockManyType.isEmpty == false {
            let stockManyToInt = Int(stockMany) ?? 0
            let stock = Store(name: stockName, UpDate: Date(), DownDate: stockDate, many: stockManyToInt, manytype: stockManyType, saveStyle: stockType)
            
            viewModel.addStock(data: stock)
            viewModel.saveData()
            delegate?.updateStoreData()
            dismiss(animated: true)
        }
        else {
            ToastView.shared.short(self.view, txt_msg: "입력되지 않은 정보가 있습니다.")
        }
    }
}
