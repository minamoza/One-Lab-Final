//
//  UserPhotosService.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import Foundation
import Alamofire

protocol UserPhotosService{
    func getPhotos(success:@escaping ([Photo]) -> Void, failure:@escaping (Error) -> Void, username: String, param: String)
}

class UserPhotosServiceImpl: UserPhotosService{
    
    func getPhotos(success:@escaping ([Photo]) -> Void, failure:@escaping (Error) -> Void, username: String, param: String) {
        let urlString = String(format: "%@users/\(username)/\(param)", EndPoint.baseurl)
        guard let url = URL(string: urlString) else { return }
        
        let queryParams: Parameters = ["client_id": EndPoint.apiKey]
        AF.request(url, method: .get, parameters: queryParams).responseDecodable{(response: DataResponse<[Photo], AFError>) in

            switch response.result{
            case .success(let collectionData):
                success(collectionData)
            case .failure(let error):
                failure(error)
            }
        }
        
    }
    
}


