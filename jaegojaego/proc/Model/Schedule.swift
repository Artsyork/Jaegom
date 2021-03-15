//
//  Schedule.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import Foundation


// 일정 데이터 정의
class Schedule : NSObject, NSCoding {
    var scheduleTitle: String // 메모
    var scheduleTime: String // 시간
    
    let key =  Date().timeIntervalSince1970
    
    static func == (lhs: Schedule  , rhs: Schedule) -> Bool {
        return lhs.key == rhs.key
    }
    
    init(scheduleTitle: String, scheduleTime: String) {
        self.scheduleTitle = scheduleTitle
        self.scheduleTime = scheduleTime
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.scheduleTitle = aDecoder.decodeObject(forKey: "scheduleTitle") as! String
        self.scheduleTime = aDecoder.decodeObject(forKey: "scheduleTime") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.scheduleTitle, forKey: "scheduleTitle")
        aCoder.encode(self.scheduleTime, forKey: "scheduleTime")
    }
}
