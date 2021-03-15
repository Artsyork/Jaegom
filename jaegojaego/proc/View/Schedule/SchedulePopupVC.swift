//
//  SchedulePopupVC.swift
//  proc
//
//  Created by 성다연 on 31/07/2019.
//  Copyright © 2019 swuad-19. All rights reserved.
//

import UIKit
import Foundation

class SchedulePopupVC: UIViewController {
    @IBOutlet weak var popupDate: UILabel! {
        didSet {
            popupDate.text = Date().returnString(format: "MM월 dd일")
        }
    }
    @IBOutlet weak var popupTF: UITextField! { didSet { popupTF.delegate = self } }
    @IBOutlet weak var savebBtn :UIButton!
    @IBAction func cancleBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var popupTFBottomConstraint: NSLayoutConstraint!
    
    private let viewModel = ScheduleViewModel()
    private var userStringDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpkeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SchedulePopupVC : UITextFieldDelegate {
    private func setUpSubViews() {
        savebBtn.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    private func setUpkeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        popupTFBottomConstraint.constant = 212
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }
    @objc func keyboardWillHide(_ sender: Notification){
        popupTFBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }


    @objc func saveButton(){
        guard let texts = popupTF.text else { return }
        
        if !texts.isEmpty {
            let newData = Schedule(scheduleTitle: texts, scheduleTime: Date().returnString(format: "yyyyMMdd"))
            viewModel.addSchedule(data: newData)
        }
        dismiss(animated: true)
    }
}
