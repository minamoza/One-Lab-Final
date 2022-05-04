//
//  TableViewCell.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 02.05.2022.
//

import UIKit

typealias EditorialCellConfigurator = TableCellConfigurator<EditorialViewCell, EditorialModel>

class EditorialViewCell: UITableViewCell, ConfigurableCell {
    
    typealias DataType = EditorialModel
    static let identifier = "EditorialViewCell"
    
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .systemBlue
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setup()
     }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
    override func layoutSubviews() {
         super.layoutSubviews()
        
     }
    
    private func setup(){
        contentView.addSubview(mainImage)
        mainImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainImage.addSubview(title)
        title.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(data: EditorialModel) {
        mainImage.image = UIImage(named: data.imageName)
//        title.text = data.title
    }
    
    



}
