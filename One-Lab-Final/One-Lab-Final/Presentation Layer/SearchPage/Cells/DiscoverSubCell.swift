//
//  DiscoverCell.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import UIKit

typealias DiscoverCellConfigurator = CollectionViewCellConfigurator<DiscoverSubCell, PhotoCellModel>

class DiscoverSubCell: UICollectionViewCell, ConfigurableCell {
    
    typealias DataType = PhotoCellModel
    
    static let identifier = "DiscoverViewCell"
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Black and White"
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
            make.center.equalTo(contentView.snp.center)
            make.height.equalTo(contentView.frame.height)
            make.width.equalTo(contentView.frame.width)
        }
    }
    
    private func configureLabels(){
        label.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom)
            make.left.equalTo(imageView.snp.left)
        }
    }
    
    func configure(data: PhotoCellModel) {
        if let photoURL = URL(string: data.photoImage){
            imageView.load(url: photoURL)
        }
        label.text = data.user
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
