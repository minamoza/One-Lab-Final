//
//  SearchCollectionsCell.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import UIKit

class SearchCollectionsCell: UICollectionViewCell {
    private let identifier = "SearchCollectionsCell"
    
    private let collectionImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
     //   imageView.layer.position = .
     //   imageView.
        return imageView
    }()
    
    private let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(10)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        super.backgroundColor = .black
//        super.layer.cornerRadius = CGFloat(15)
        
        addSubview(collectionImage)
        collectionImage.snp.makeConstraints{
            $0.center.equalTo(contentView.snp.center)
            $0.size.equalTo(contentView.snp.size)
        }
        
        addSubview(collectionNameLabel)
        collectionNameLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(collectionCellHeight: CGFloat){
        collectionNameLabel.text = "test"
      // cropCollectionImage(sourceImage: UIImage(named: "test4")!,  collectionCellHeight: collectionCellHeight)
      //  collectionImage.image = UIImage(named: "testCollection")
    }
    
    func cropCollectionImage(sourceImage: UIImage, collectionCellHeight: CGFloat ){
    
        let yOffset = (sourceImage.size.height - collectionCellHeight * sourceImage.size.height/900.0)
        
        let cropRect = CGRect(
            x: 0,
            y: yOffset,
            width: sourceImage.size.width,
            height: sourceImage.size.height - yOffset * 2.0
        ).integral

        // Center crop the image
        let sourceCGImage = sourceImage.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!
        
        /*collectionImage.image =  UIImage(
            cgImage: croppedCGImage,
            scale: scaledImage.imageRendererFormat.scale,
            orientation: scaledImage.imageOrientation
        )*/
       collectionImage.image = UIImage(cgImage: croppedCGImage)
    }
}
