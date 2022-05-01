//
//  CollectionCellBuilder.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
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
