//
//  HeaderCollectionView.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 02.05.2022.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    private let label: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public func configure() {
        backgroundColor = . systemGreen
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
