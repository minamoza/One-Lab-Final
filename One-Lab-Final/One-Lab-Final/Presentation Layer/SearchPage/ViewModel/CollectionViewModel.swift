//
//  CollectionViewModel.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 05.05.2022.
//

import Foundation

class CollectionViewModel{
    private let collectionService: GetCollectionService
    
    var didLoadPhoto: (([SearchedCollections]) -> Void)?
    
    init(collectionService: GetCollectionService){
        self.collectionService = collectionService
    }
    
    func getPhotos(query: String){
        collectionService.getCollections(
            success: { [weak self] category in
//                print(category)
                self?.didLoadPhoto?(category)
        }, failure: { error in
            print(error)
        }, query: "Apple")
    }
}
