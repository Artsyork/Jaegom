//
//  Store.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//
import UIKit
import Foundation

// 보관 방법
enum SaveStyle : String {
    case Fresh = "room" //실온
    case Cold = "cold" // 냉장
    case Ice = "frozen" // 냉동
}


class Store : NSObject, NSCoding {
    var name: String // 제품 이름
    var UpDate: Date  // 등록 날
    var DownDate: Date // 유통기한
    
    var many: Int = 1// 수량
    var manytype : String // 단위 = degree..
    var saveStyle: SaveStyle = .Fresh// 보관 상태
    
    // 자동처리 값
    var TotalMany: Int = 0 // 전체 수량
    var untilDate: Int {
        return dateFormater(downdate: DownDate) }// 남은 기간 일자 (day)
    var saveImage: String? //보관상태 이미지
    var Image: String { // 그래프 이미지
        let temp:Double = Double(self.many) / Double(self.TotalMany)
    
        // 전체수량은 수량보다 작으면 안됨
        if self.TotalMany - self.many >= 0 {
            if temp > 0 && temp <= 0.25 { return "wG4-1" }
            else if temp > 0.25 && temp <= 0.5 { return "wG2" }
            else if temp > 0.5 && temp <= 0.75 { return "wG3"}
            else { return "wG1" }
        } else { return "graph_0" }
    }
    
    let key =  Date().timeIntervalSince1970
    static func == (lhs: Store, rhs: Store) -> Bool {
        return lhs.key == rhs.key
    }
    
    init(name:String, UpDate:Date, DownDate:Date, many:Int, manytype:String, saveStyle:SaveStyle){
        self.name = name
        self.UpDate = UpDate
        self.DownDate = DownDate
        
        self.many = many
        self.manytype = manytype
        self.saveStyle = saveStyle
        
        TotalMany += many
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.UpDate = aDecoder.decodeObject(forKey: "UpDate") as! Date
        self.DownDate = aDecoder.decodeObject(forKey: "DownDate") as! Date
        
        self.many = aDecoder.decodeInteger(forKey: "many")
        self.manytype = aDecoder.decodeObject(forKey: "manytype") as! String
        self.saveStyle = SaveStyle(rawValue: aDecoder.decodeObject(forKey: "saveStyle") as! String)!
        self.TotalMany += many
    }
   
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.UpDate, forKey: "UpDate")
        aCoder.encode(self.DownDate, forKey: "DownDate")
        
        aCoder.encode(self.many, forKey: "many")
        aCoder.encode(self.manytype, forKey: "manytype")
        aCoder.encode(self.saveStyle.rawValue, forKey: "saveStyle")
    }
    
    // 남은 기간 계산하기
    func dateFormater(downdate:Date) -> Int {
        let dateformat = downdate.timeIntervalSince1970 - Date().timeIntervalSince1970
        return Int(dateformat / 24 / 60 / 60)
    }
}


