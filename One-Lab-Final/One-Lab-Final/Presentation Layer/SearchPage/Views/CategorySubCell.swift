//
//  CategoryCell.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import SnapKit

typealias CategoryCellConfigurator = CollectionViewCellConfigurator<CategorySubCell, CategoryModel>

class CategorySubCell: UICollectionViewCell, ConfigurableCell {

    typealias DataType = CategoryModel
    
    static let identifier = "CollectionViewCell"
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        configureImageView()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView(){
        imageView.snp.makeConstraints { make in
//            make.centerX.equalTo(contentView.snp.centerX)
            make.center.equalTo(contentView.snp.center)
            make.size.equalTo(contentView.frame.height)
        }
    }
    
    private func configureLabels(){
        label.snp.makeConstraints { make in
            make.center.equalTo(imageView.snp.center)
        }
    }
    
    func configure(data: CategoryModel) {
        imageView.image = UIImage(named: data.image)
        label.text = data.description
    }
    
    
}
