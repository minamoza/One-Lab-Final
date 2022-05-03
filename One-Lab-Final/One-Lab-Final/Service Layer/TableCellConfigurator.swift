//
//  CellConfigurator.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 02.05.2022.
//

import UIKit

//protocol CellConfigurator{
//    static var reuseId: String { get }
//    static var cellClass: AnyClass { get }
//    func configure(cell: UIView)
//}

// GENERICS OF CELL DATAYPE

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    static var reuseId: String{return String(describing: CellType.self)}
    static var cellClass: AnyClass { return CellType.self }
    
    let item: DataType
    
    init(item: DataType) {
            self.item = item
        }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
    
    
    
}
