//
//  CollectionCellBuilder.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 28.04.2022.
//

import Foundation

class CollectionCellBuilder: CellBuilder{
    var configurableCells: [CellConfigurator] = []
    
    @discardableResult
    func setCategoryCell(with category: CategoryModel) -> Self{
        configurableCells.append(CategoryCellConfigurator(item: category))
        return self
    }
    
    @discardableResult
    func setDiscoverCell(with photo: PhotoCell) -> Self{
        configurableCells.append(DiscoverCellConfigurator(item: photo))
        return self
    }
}
