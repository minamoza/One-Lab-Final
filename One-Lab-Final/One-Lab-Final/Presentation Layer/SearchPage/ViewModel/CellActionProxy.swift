//
//  CellActionProxy.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import Foundation
import UIKit

class CellActionProxy {
    private var actions = [String: ((CellConfigurator, UIView) -> Void)]()
    
    func invoke(action: CellAction, cell: UIView, configurator: CellConfigurator) {
       let key = "\(action.hashValue)\(type(of: configurator).reuseId)"
      //  let key = ""
        if let action = actions[key] {
            action(configurator, cell)
        }
    }
    
    @discardableResult
    func on<CellType, DataType>(action: CellAction, handler: @escaping ((TableCellConfigurator<CellType, DataType>, CellType) -> Void)) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        actions[key] = { c, cell in
            handler(c as! TableCellConfigurator<CellType, DataType>, cell as! CellType)
        }
        return self
    }
}

