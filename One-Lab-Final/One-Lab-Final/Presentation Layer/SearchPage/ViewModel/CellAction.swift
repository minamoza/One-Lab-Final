//
//  CellAction.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import Foundation
import UIKit

enum CellAction: Hashable {
    case didSelect
    case willDisplay
    
 var hashValue: Int {
        switch self {
        case .didSelect: return 0
        case .willDisplay: return 1
       }
        }
    }

struct CellActionEventData {
    let action: CellAction
    let cell: UIView
}

extension CellAction {
    static let notificationName = NSNotification.Name("cellAction")
    
    func invoke(cell: UIView) {
        NotificationCenter.default.post(name: CellAction.notificationName, object: nil, userInfo: ["data": CellActionEventData(action: self, cell: cell)])
    }
}

