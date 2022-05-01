//
//  CellBuilder.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import Foundation

protocol CellBuilder{
    var configurableCells: [CellConfigurator]{
        get set
    }
    
    mutating func reset() -> Self
    
    func getConfigurableCells() -> [CellConfigurator]
}

extension CellBuilder {
    mutating func reset() -> Self{
        configurableCells = []
        return self
    }
    
    func getConfigurableCells() -> [CellConfigurator] {
        return configurableCells
    }
}
