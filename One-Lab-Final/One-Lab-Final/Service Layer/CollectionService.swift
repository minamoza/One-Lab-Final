//
//  CollectionService.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import Foundation
import Alamofire
import AlamofireImage

protocol GetCollectionService{
    func getCollections(success:@escaping ([SearchedCollections]) -> Void, failure:@escaping (Error) -> Void, query: String)
}

class GetCollectionServiceImpl: GetCollectionService{
    
    func getCollections(success:@escaping ([SearchedCollections]) -> Void, failure:@escaping (Error) -> Void, query: String) {
        let urlString = String(format: "%@collections", EndPoint.baseurl)
        guard let url = URL(string: urlString) else { return }
        
        let queryParams: Parameters = ["client_id": EndPoint.apiKey, "query": query]
        AF.request(url, method: .get, parameters: queryParams).responseDecodable{(response: DataResponse<[SearchedCollections], AFError>) in

            switch response.result{
            case .success(let collectionData):
                success(collectionData)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

struct Collections: Codable {
    let total, totalPages: Int
    let results: [SearchedCollections]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct SearchedCollections: Codable {
    let title: String
    let featured: Bool
    let totalPhotos: Int
    let resultPrivate: Bool
    let shareKey: String
    let coverPhoto: CoverPhoto

    enum CodingKeys: String, CodingKey {
        case title
        case featured
        case totalPhotos = "total_photos"
        case resultPrivate = "private"
        case shareKey = "share_key"
        case coverPhoto = "cover_photo"
    }
}
