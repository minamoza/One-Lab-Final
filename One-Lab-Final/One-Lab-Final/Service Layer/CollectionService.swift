//
//  CollectionService.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 30.04.2022.
//

import Foundation
import Alamofire
import AlamofireImage

protocol GetCollectionService{
    func getCollections(success:@escaping ([Photo]) -> Void, failure:@escaping (Error) -> Void)
}

class GetCollectionServiceImpl: GetCollectionService{
    
    func getCollections(success:@escaping ([Photo]) -> Void, failure:@escaping (Error) -> Void) {
        let urlString = String(format: "%@collections", EndPoint.baseurl)
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
