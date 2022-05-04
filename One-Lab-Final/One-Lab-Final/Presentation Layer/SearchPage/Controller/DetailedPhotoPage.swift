//
//  DetailedPhotoPage.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 02.05.2022.
//

import UIKit

class DetailedPhotoPage: UIViewController {
    
    private let imageView = UIImageView()
    
    private let imageUrl: String
    private let titleText: String
    
    init(imageUrl: String, titleText: String){
        self.imageUrl = imageUrl
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain,
                                                            target: self, action: nil)
        
        title = titleText
        imageView.load(url: URL(string: imageUrl)!)
        
        configureimageView()

    }
    
    func configureimageView(){
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
