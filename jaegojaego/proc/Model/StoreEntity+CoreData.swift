//
//  StoreEntity+CoreData.swift
//  proc
//
//  Created by 성다연 on 2021/03/05.
//  Copyright © 2021 swuad-19. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension StoreEntity {
    static var entityName: String {
        return entity().name!
    }
}
