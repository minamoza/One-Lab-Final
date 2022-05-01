//
//  SearchedPhotoService.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 01.05.2022.
//

import Foundation
import AlamofireImage
import Alamofire

protocol GetSearchedPhotoService{
    func searchPhotos(success:@escaping ([Result]) -> Void, failure:@escaping (Error) -> Void, query: String)
}

class GetSearchedPhotoImpl: GetSearchedPhotoService{
    func searchPhotos(success:@escaping ([Result]) -> Void, failure:@escaping (Error) -> Void, query: String){
        let urlString = String(format: "%@search/photos", EndPoint.baseurl)
        guard let url = URL(string: urlString) else { return }
        
        let queryParams: Parameters = ["client_id": EndPoint.apiKey, "page": "1", "query": query]
        AF.request(url, method: .get, parameters: queryParams).responseDecodable{(response: DataResponse<SearchedPhoto, AFError>) in
            switch response.result{
            case .success(let collectionData):
                success(collectionData.results)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

// MARK: - Welcome
struct SearchedPhoto: Codable {
    let total, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let id: String
    let createdAt: String
    let width, height: Int
    let color, blurHash: String
    let likes: Int
    let likedByUser: Bool
//    let resultDescription: String
    let user: User
//    let currentUserCollections: [JSONAny]
    let urls: Urls
    let links: ResultLinks

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height, color
        case blurHash = "blur_hash"
        case likes
        case likedByUser = "liked_by_user"
//        case resultDescription = "description"
        case user
//        case currentUserCollections = "current_user_collections"
        case urls, links
    }
}

// MARK: - ResultLinks
struct ResultLinks: Codable {
    let linksSelf: String
    let html, download: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
    }
}
