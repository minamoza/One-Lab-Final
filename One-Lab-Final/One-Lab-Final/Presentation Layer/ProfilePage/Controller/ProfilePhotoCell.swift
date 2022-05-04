//
//  ProfilePhotoCell.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import UIKit

class ProfilePhotoCell: UITableViewCell {
    
    static let identifier = "ProfilePhotoCell"
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureimageView(){
        contentView.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.edges.equalTo(contentView)
        }
    }
    
    func configureCell(photoUrl: String){
        image.load(url: URL(string: photoUrl)!)
        configureimageView()
    }

}
