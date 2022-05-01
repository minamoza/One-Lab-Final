//
//  CellBuilder.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 28.04.2022.
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
