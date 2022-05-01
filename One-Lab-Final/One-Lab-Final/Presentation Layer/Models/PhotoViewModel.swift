//
//  CategoryViewModel.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 30.04.2022.
//

import Foundation

class PhotoViewModel{
    private let photoService: GetPhotoService
    
    var didLoadPhoto: (([Photo]) -> Void)?
    
    init(photoService: GetPhotoService){
        self.photoService = photoService
    }
    
    func getPhotos(){
        photoService.getPhotos(
            success: { [weak self] category in
//                print(category)
                self?.didLoadPhoto?(category)
        }, failure: { error in
            print(error)
        })
    }
}
