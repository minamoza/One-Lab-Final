//
//  ConfigurableCell.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    static var reuseIdentifier: String { get }
    func configure(data: DataType)
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
