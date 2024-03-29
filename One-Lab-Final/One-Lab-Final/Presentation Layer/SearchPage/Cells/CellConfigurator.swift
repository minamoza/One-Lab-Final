//
//  CellConfigurator.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import Foundation
import UIKit

protocol CellConfigurator {
    static var reuseId: String { get }
    static var cellClass: AnyClass { get }
    func configure(cell: UIView)
}

class CollectionViewCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UICollectionViewCell {
    
    static var reuseId: String { return CellType.reuseIdentifier }
    static var cellClass: AnyClass { return CellType.self }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
    
}


