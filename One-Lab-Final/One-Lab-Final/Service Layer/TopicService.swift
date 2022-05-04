//
//  TopicService.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 04.05.2022.
//

import Foundation
import AlamofireImage
import Alamofire

protocol GetTopicService{
    func getTopic(success:@escaping ([Topic]) -> Void, failure:@escaping (Error) -> Void)
}

class GetTopicImpl: GetTopicService{
    func getTopic(success:@escaping ([Topic]) -> Void, failure:@escaping (Error) -> Void){
        let urlString = String(format: "%@/topics", EndPoint.baseurl)
        guard let url = URL(string: urlString) else { return }
        
        let queryParams: Parameters = ["client_id": EndPoint.apiKey]
        AF.request(url, method: .get, parameters: queryParams).responseDecodable{(response: DataResponse<[Topic], AFError>) in
            switch response.result{
            case .success(let topic):
                success(topic)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

