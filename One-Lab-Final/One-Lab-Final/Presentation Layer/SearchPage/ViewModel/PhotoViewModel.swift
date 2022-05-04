//
//  PhotoViewModel.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
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
