//
//  UserSearchModel.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import Foundation

class UserViewModel{
    private let userService: UserService
    
    var didLoadPhoto: (([SearchedUsers]) -> Void)?
    
    init(userService: UserService){
        self.userService = userService
    }
    
    func getUsers(query: String){
        userService.getUsers(
            success: { [weak self] category in
//                print(category)
                self?.didLoadPhoto?(category)
        }, failure: { error in
            print(error)
        }, query: query)
    }
}

class UserPhotosViewModel{
    private let userPhotosService: UserPhotosService
    
    var didLoadPhoto: (([Photo]) -> Void)?
    
    init(userService: UserPhotosService){
        self.userPhotosService = userService
    }
    
    func getPhotoss(username: String, param: String){
        userPhotosService.getPhotos(
            success: { [weak self] category in
//                print(category)
                self?.didLoadPhoto?(category)
        }, failure: { error in
            print(error)
        }, username: username, param: param)
    }
}
