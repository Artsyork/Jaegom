//
//  ScheduleViewModel.swift
//  proc
//
//  Created by 성다연 on 2021/02/27.
//  Copyright © 2021 swuad-19. All rights reserved.
//

import Foundation

class ScheduleViewModel {
    private var ScheduleArray : [Schedule] = []
    
    private var schedulFilePath : String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/JaegoJaego/JaegoSchedule.file"
        }
    }
    
    init(){
        setArchiveFile()
    }
}


extension ScheduleViewModel {
    func addSchedule(data : Schedule) {
        ScheduleArray.append(data)
    }
    
    func removeSchedule(data: Schedule) {
        ScheduleArray.append(data)
    }
    
    func findSchedule(index data: Int) -> Schedule {
        return ScheduleArray[data]
    }
    
    func returnScheduleAt(date : String) -> [Schedule] {
        return ScheduleArray.filter { $0.scheduleTime == date }
    }
    
    func returnScheduleDateArray() -> [String] {
        return ScheduleArray.compactMap { $0.scheduleTime }
    }
    
    private func setArchiveFile(){
        if FileManager.default.fileExists(atPath: self.schedulFilePath){
            if let scheduleArrayList = NSKeyedUnarchiver.unarchiveObject(withFile: self.schedulFilePath) as? [Schedule] {
                ScheduleArray += scheduleArrayList
            }
        } else { ScheduleArray += setDefaultData() }
    }
    
    private func setDefaultData() -> [Schedule]{
        let stock1 = Schedule(scheduleTitle: "채끝 200g", scheduleTime: "20210220")
        let stock2 =  Schedule(scheduleTitle: "예약 4팀", scheduleTime:"20210122")
        let stock3 =  Schedule(scheduleTitle: "순두부 추가 주문", scheduleTime:"20210126")
        let stock4 =  Schedule(scheduleTitle: "예약 7팀", scheduleTime:"20210125")
        let stock5 =  Schedule(scheduleTitle: "핫도그 재고 드랍", scheduleTime:"20210130")
        let stock6 =  Schedule(scheduleTitle: "예약 5팀", scheduleTime:"20210226")
        let stock7 =  Schedule(scheduleTitle: "예약 2팀", scheduleTime:"20210224")
        
        return [stock1, stock2, stock3, stock4, stock5, stock6,stock7]
    }
    
    func saveData(){
        NSKeyedArchiver.archiveRootObject(self.ScheduleArray, toFile: self.schedulFilePath)
    }
}
