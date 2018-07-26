//
//  AddStoreViewController.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 24..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import Foundation
import UIKit

class AddStoreViewController:UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let AddPikDate = UIPickerView()
        
        AddPikDate.delegate = self
        
        AddldlDatePiker.inputView = AddPikDate
    }
    
     var myPickerData = [["2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030"],["1","2","3","4","5","6","7","8","9","10","11","12"],
        ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return myPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = myPickerData[0][pickerView.selectedRow(inComponent: 0)]
        let month = myPickerData[1][pickerView.selectedRow(inComponent: 1)]
        let day = myPickerData[2][pickerView.selectedRow(inComponent: 2)]
        AddldlDatePiker.text = year + "-" + month + "-" + day
    }
    
    
    @IBOutlet weak var AddlblName :UITextField!
    @IBOutlet weak var AddlblMany :UITextField!
    @IBOutlet weak var AddlblDate: UITextField!
    @IBOutlet weak var AddbtnSave: UIButton! //저장방법
    @IBOutlet weak var AddlblCall: UITextField!
    
    @IBOutlet weak var AddbtnFinish: UIButton! //완료
    
    //피커뷰 사용
    @IBOutlet weak var AddldlDatePiker: UITextField!
    
    
    
   // @IBOutlet weak var womanRadioButton: RadioButton!
   // @IBOutlet weak var manRadioButton: RadioButton!
    
    /*
    //라디오 버튼
    override func awakeFromNib() {
        self.view.layoutIfNeeded()
        
        womanRadioButton.isSelected = true
        manRadioButton.isSelected = false
    }
    */
    
  
    // 화면 아무곳 누르면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
/*
    @IBAction func getValue () {
        var Nametext:String = AddlblName.text!
        var Manytext:String = AddlblMany.text!
        var DateAdd:String = AddlblDate.text!
        var CallAdd:String = AddlblCall.text!
    }
 */
    
    //버튼 클릭했을 때 함수
    @IBAction func saveAddInfoBtn(_ sender: AnyObject) {
        var test = StoreModel_More.init()
        var infoDateAdd:String = HomeViewController.dateInfo()
        
        var NameAdd:String = AddlblName.text!
        var ManyAdd:Int = Int(AddlblMany.text!)!
        var DateAdd:String = AddlblDate.text!
        var CallAdd:String = AddlblCall.text!
        var SaveAdd:saveStyle = .Cold
        var TtManyAdd:Int = (30 + ManyAdd)
        
        //시험용 배열 데이터 선언
        var addStock = Store(name: NameAdd, UpDate: infoDateAdd, DownDate: DateAdd, many: ManyAdd, saveStyle: SaveAdd, TotalMany: TtManyAdd, Call: CallAdd)
        
        // 데이터 받기, 출력 확인
//        print(addStock)
//
//        test.arrayList.append(addStock)
//        for i in 0..<test.arrayList.count {
//            print(test.arrayList[i])
//        }
//    }
    }
}
