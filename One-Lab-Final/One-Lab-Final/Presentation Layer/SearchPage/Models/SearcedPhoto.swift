//
//  SearcedPhoto.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import Foundation


class SearchedPhotoViewModel{
    private let photoService: GetSearchedPhotoService
    
    var didLoadPhoto: (([Result]) -> Void)?
    
    init(photoService: GetSearchedPhotoService){
        self.photoService = photoService
    }
    
    func getPhotos(query: String){
        photoService.searchPhotos(
            success: { [weak self] category in
//                print(category)
                self?.didLoadPhoto?(category)
        }, failure: { error in
            print(error)
        }, query: query)
    }
}
